module Plugin (plugin) where
import GhcPlugins

plugin :: Plugin
plugin = defaultPlugin {
  installCoreToDos = install
  }

install :: [CommandLineOption] -> [CoreToDo] -> CoreM [CoreToDo]
install _ todo = do
  return $ todo  ++ [CoreDoSpecialising, simpl_pass ]
  where
    pp = CoreDoPluginPass "add-inline" pass
    simpl_pass = CoreDoSimplify 3 (SimplMode ["last"] (Phase 0) True True True True)

pass :: ModGuts -> CoreM ModGuts
pass mg = return $ mg { mg_binds =  progPass (mg_binds mg) }

progPass :: CoreProgram -> CoreProgram
progPass cp = map addInline cp

addInline :: Bind CoreBndr -> Bind CoreBndr
addInline (NonRec b rhs) = NonRec (mod_binder b) rhs
  where
    mod_binder var =
      let s = occNameString (getOccName var)
      in if s == "$cto" || s == "$fGenericLogic"
          then pprTrace "Adding to:" (ppr s) (modifyInlinePragma var (\_ -> alwaysInlinePragma))
          else pprTrace "Ignoring:" (ppr s) var
addInline (Rec bs) = Rec bs


