package yishi.actions.consortia
{
   import yishi.SwitchPageHelp;
   import yishi.actions.map.MapBaseAction;
   import yishi.scene.SceneManager;
   
   public class GuildWantedBattleAction extends MapBaseAction
   {
      
      public function GuildWantedBattleAction()
      {
         super();
      }
      
      override public function update() : void
      {
         if(SceneManager.instance.currentType == "CASTLE_SCENE" || SceneManager.instance.currentType == "SPACE_SCENE")
         {
            dispose();
            SwitchPageHelp.openGuildWantedFrame();
         }
      }
   }
}

