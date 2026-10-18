package playerinfo.view.playerattribute
{
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.utils.IconFactory;
   
   public class PlayerThaneView extends ThaneView
   {
      
      public function PlayerThaneView()
      {
         super();
      }
      
      public function refreshIcon(param1:ThaneInfo) : void
      {
         _icon.icon = IconFactory.getPlayerIcon(param1.templateId,"half",".jpg");
      }
   }
}

