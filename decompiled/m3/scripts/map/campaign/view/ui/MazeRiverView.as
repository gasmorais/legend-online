package map.campaign.view.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignSocketOutManager;
   import yishi.datas.playerinfo.TowerInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class MazeRiverView extends Sprite implements Disposeable
   {
      
      private static var _riverCount:int;
      
      private var _bg:Scale9CornerImage;
      
      private var _riverBtn:IconButton;
      
      private var _txt:FilterFrameText;
      
      private var _cost:int;
      
      private var _cannelBtn:TextButton;
      
      public function MazeRiverView()
      {
         super();
         init();
         addEvent();
      }
      
      public static function addRiverCount() : void
      {
         _riverCount = _riverCount + 1;
      }
      
      public function set cost(param1:int) : void
      {
         _cost = param1;
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("campaign.maze.river.RiverViewBg");
         addChild(_bg);
         _riverBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.maze.woundinfo.RiverBtn");
         addChild(_riverBtn);
         _txt = ComponentFactory.Instance.creatComponentByStylename("campaign.maze.river.riverTxt");
         addChild(_txt);
         _txt.text = LanguageMgr.GetTranslation("map.campaign.view.ui.MazeRiverView.txt");
         _cannelBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.maze.MazeRiverCannelBtn");
         addChild(_cannelBtn);
         _cannelBtn.text = LanguageMgr.GetTranslation("public.cancel");
      }
      
      private function addEvent() : void
      {
         _riverBtn.addEventListener("click",__riverClickHandler);
         _cannelBtn.addEventListener("click",__cannelClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_riverBtn)
         {
            _riverBtn.removeEventListener("click",__riverClickHandler);
         }
         if(_cannelBtn)
         {
            _cannelBtn.removeEventListener("click",__cannelClickHandler);
         }
      }
      
      private function __riverClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         SoundManager.instance.play("022");
         if(_cost == 0)
         {
            SocketSendManager.instance.sendTowerRiver(true);
         }
         else if(_riverCount > 2)
         {
            __riverCall();
         }
         else
         {
            SimpleAlertHelper.instance.data = [__riverCall];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("map.campaign.view.ui.MazeRiverView.content01");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2,"USEBINDPOINT_ALERT",0,"",null,"SimpleAlert",_cost);
         }
      }
      
      private function __cannelClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:String = null;
         SoundManager.instance.play("022");
         var _loc4_:int = int(CampaignManager.instance.mapModel.campaignTemplate.SonTypes);
         if(towerInfo.enterCount == 0)
         {
            _loc6_ = LanguageMgr.GetTranslation("map.campaign.view.ui.MazeRiverView.content05");
         }
         else
         {
            _loc6_ = LanguageMgr.GetTranslation("map.campaign.view.ui.MazeRiverView.content02");
         }
         SimpleAlertHelper.instance.data = [__cannelCall];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true);
      }
      
      private function get towerInfo() : TowerInfo
      {
         return PlayerManager.instance.currentPlayerModel.towerInfo;
      }
      
      private function __cannelCall(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            CampaignSocketOutManager.instance.sendReturnCampaignRoom(ArmyManager.instance.army.id);
         }
      }
      
      private function __riverCall(param1:Boolean = true, param2:Boolean = true) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc3_:int = 0;
         if(param2)
         {
            _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         else
         {
            _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         }
         if(_loc3_ < _cost)
         {
            RechargeAlertMannager.show();
            return;
         }
         SocketSendManager.instance.sendTowerRiver(param2);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_cannelBtn)
         {
            _cannelBtn.dispose();
         }
         _cannelBtn = null;
         if(_riverBtn)
         {
            _riverBtn.dispose();
         }
         _riverBtn = null;
         if(_txt)
         {
            _txt.dispose();
         }
         _txt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

