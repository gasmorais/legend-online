package worldmap
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.outercity.manager.OuterCityManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.utils.WorldMapHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class WorldMapFrame extends Frame
   {
      
      private var _mapNum:int = 5;
      
      private var _unopenList:Array = [5];
      
      private var _worldBg:Bitmap;
      
      private var _mapAreaContainer:MovieImage;
      
      private var __mapId:int;
      
      public function WorldMapFrame()
      {
         super();
         iniView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function iniView() : void
      {
         _worldBg = ComponentFactory.Instance.creatBitmap("asset.worldmap.Bg");
         addChild(_worldBg);
         _mapAreaContainer = ComponentFactory.Instance.creatComponentByStylename("worldmap.MapAreaContainer");
         addToContent(_mapAreaContainer);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _mapAreaContainer = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function addEvent() : void
      {
         var _loc1_:int = 0;
         addEventListener("response",__frameResponse);
         _loc1_ = 1;
         while(_loc1_ <= _mapNum)
         {
            _mapAreaContainer.movie["map" + _loc1_].addEventListener("click",__mouseClickHandler);
            _loc1_++;
         }
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         var _loc2_:SimpleButton = null;
         removeEventListener("response",__frameResponse);
         if(_mapAreaContainer)
         {
            _loc1_ = 0;
            while(_loc1_ < _mapAreaContainer.numChildren)
            {
               _loc2_ = _mapAreaContainer.getChildAt(_loc1_) as SimpleButton;
               if(_loc2_)
               {
                  _loc2_.removeEventListener("click",__mouseClickHandler);
               }
               _loc1_++;
            }
         }
      }
      
      private function isOpenByIndex(param1:int) : Boolean
      {
         for each(var _loc2_:int in _unopenList)
         {
            if(_loc2_ == param1)
            {
               return false;
            }
         }
         return true;
      }
      
      protected function __mouseClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:String = param1.currentTarget.name;
         __mapId = WorldMapHelper.tagNameToMapId(_loc4_);
         SimpleAlertHelper.instance.data = [__exitSocketHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc5_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc6_:String = LanguageMgr.GetTranslation("worldmap.view.WorldMapFrame.content");
         SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,false,false);
      }
      
      private function __exitSocketHandler(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:String = null;
         if(param1)
         {
            if(!checkScene())
            {
               return;
            }
            if(!checkArmyState())
            {
               return;
            }
            if(__mapId == PlayerManager.instance.currentPlayerModel.mapNodeInfo.info.mapId)
            {
               _loc3_ = LanguageMgr.GetTranslation("worldmap.view.WorldMapFrame.command01");
               MessageTipManager.instance().show(_loc3_);
            }
            else
            {
               FrameControllerManager.instance.worldMapController.sendMap(__mapId);
            }
         }
      }
      
      private function checkArmyState() : Boolean
      {
         var _loc2_:Object = null;
         var _loc1_:Boolean = true;
         if(currentScene == "OUTER_CITY_SCENE")
         {
            if(OuterCityManager.instance.controler.selfArmy && OuterCityManager.instance.controler.selfArmy.armyView)
            {
               _loc2_ = OuterCityManager.instance.controler.selfArmy.armyView;
               if(_loc2_.hasOwnProperty("isStand"))
               {
                  if(_loc2_["isStand"])
                  {
                     return true;
                  }
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("worldmap.view.WorldMapFrame.walking"));
                  return false;
               }
            }
         }
         return _loc1_;
      }
      
      public function checkScene() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:String = "";
         if(currentScene == "CAMPAIGN_MAP_SCENE")
         {
            _loc2_ = int(CampaignManager.instance.mapModel.mapId);
            if(WorldBossHelper.checkDuskArea(_loc2_) || Boolean(WorldBossHelper.checkFlameTemple(_loc2_)) || Boolean(WorldBossHelper.checkIceFireTemple(_loc2_)))
            {
               _loc1_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip16");
            }
            else if(WorldBossHelper.checkConsortiaSecretLand(_loc2_))
            {
               _loc1_ = LanguageMgr.GetTranslation("worldboss.helper.WorldBossHelper.tip08");
            }
            else
            {
               _loc1_ = LanguageMgr.GetTranslation("worldmap.view.WorldMapFrame.command02");
            }
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         if(currentScene == "PVE_ROOM_SCENE" || currentScene == "PVP_ROOM_SCENE" || currentScene == "WARLORDS_ROOM")
         {
            _loc1_ = LanguageMgr.GetTranslation("worldmap.view.WorldMapFrame.command03");
            MessageTipManager.instance().show(_loc1_);
            return false;
         }
         return true;
      }
      
      private function get currentScene() : String
      {
         return SceneManager.instance.currentType;
      }
      
      private function __closeHandler(param1:Event) : void
      {
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
      }
      
      public function get mapAreaContainer() : MovieImage
      {
         return _mapAreaContainer;
      }
      
      public function get closeBtn() : BaseButton
      {
         return _closeButton;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninit();
         super.dispose();
      }
   }
}

