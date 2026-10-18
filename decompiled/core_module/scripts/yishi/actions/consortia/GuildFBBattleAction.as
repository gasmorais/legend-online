package yishi.actions.consortia
{
   import yishi.SwitchPageHelp;
   import yishi.actions.map.MapBaseAction;
   import yishi.scene.SceneManager;
   
   public class GuildFBBattleAction extends MapBaseAction
   {
      
      public function GuildFBBattleAction()
      {
         super();
      }
      
      override public function update() : void
      {
         if(SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE")
         {
            dispose();
            SwitchPageHelp.openGuildFbFrame();
         }
      }
   }
}

