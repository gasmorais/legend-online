package yishi.utils
{
   import com.pickgliss.loader.LoaderSavingManager;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.SoundManager;
   import flash.events.ContextMenuEvent;
   import flash.ui.ContextMenu;
   import flash.ui.ContextMenuItem;
   import manager.ExternalInterfaceManager;
   import manager.LanguageMgr;
   import yishi.manager.PathManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteSaveManager;
   
   public class RightMenuUtils
   {
      
      public function RightMenuUtils()
      {
         super();
      }
      
      public static function setup() : void
      {
         LayerManager.Instance.getLayerByType(8).contextMenu = creatRightMenu(LanguageMgr.GetTranslation("yishi.loader.StartupResourceLoader.storeGame"),LanguageMgr.GetTranslation("yishi.loader.StartupResourceLoader.recharge"),LanguageMgr.GetTranslation("yishi.loader.StartupResourceLoader.cleanTemp"));
      }
      
      public static function creatRightMenu(param1:String = "", param2:String = "", param3:String = "") : ContextMenu
      {
         var _loc5_:ContextMenu = new ContextMenu();
         _loc5_.hideBuiltInItems();
         var _loc4_:ContextMenuItem = new ContextMenuItem(param1,true,true);
         _loc4_.addEventListener("menuItemSelect",storeGame);
         var _loc7_:ContextMenuItem = new ContextMenuItem(param2,false,true);
         _loc7_.addEventListener("menuItemSelect",recharge);
         var _loc6_:ContextMenuItem = new ContextMenuItem(param3,false,true);
         _loc6_.addEventListener("menuItemSelect",cleanTemp);
         _loc5_.customItems = [_loc4_,_loc7_,_loc6_];
         return _loc5_;
      }
      
      private static function cleanTemp(param1:ContextMenuEvent) : void
      {
         LoaderSavingManager.cleanTempSaveFile();
         TempleteSaveManager.instance.clean();
      }
      
      private static function recharge(param1:ContextMenuEvent) : void
      {
         SoundManager.instance.play("022");
         RechargeAlertMannager.navigateToRechargePage();
      }
      
      protected static function storeGame(param1:ContextMenuEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("yishi.manager.GameStoreManager.SQsevenRoad");
         ExternalInterfaceManager.instance.navigateToStore(_loc2_,PathManager.info.SITE);
      }
   }
}

