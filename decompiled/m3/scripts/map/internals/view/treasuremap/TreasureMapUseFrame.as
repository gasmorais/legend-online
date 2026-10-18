package map.internals.view.treasuremap
{
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.TreasureMapEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.TreasureMapManager;
   import managers.TreasureMapSocketOutManager;
   import map.campaign.CampaignManager;
   import map.internals.data.template.MapTemplate;
   import mvc.module.treasuremap.TreasureMapModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.WorldBossHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.newGuildHelp.NewGuildFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class TreasureMapUseFrame extends Frame implements IManualSize
   {
      
      private const FRAME_WIDTH:int = 455;
      
      private const FRAME_HEIGHT:int = 491;
      
      private const GROUP_WIDTH:int = 1159;
      
      private var _rect:Rectangle;
      
      private var _digBtn:IconButton;
      
      private var _helpBtn:BaseButton;
      
      private var _bg:Scale9CornerImage;
      
      private var _smallMapContainer:Sprite;
      
      private var _smallMap:Bitmap;
      
      private var _flag:Bitmap;
      
      private var _info:GoodsInfo;
      
      private var _mapTile:String;
      
      private var _flagPosX:int;
      
      private var _flagPosY:int;
      
      private var _mapName:String;
      
      private var _digPointsCost:int = 0;
      
      private var _checkMap:FilterFrameText;
      
      public function TreasureMapUseFrame()
      {
         super();
         _digPointsCost = getConfigValue("treasure_imm_battle");
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return _rect;
      }
      
      override public function get groups() : Array
      {
         return ["TREASURE_MAP_GROUP"];
      }
      
      private function getConfigValue(param1:String) : int
      {
         if(TempleteManager.instance.getConfigInfoByConfigName(param1))
         {
            return int(TempleteManager.instance.getConfigInfoByConfigName(param1).ConfigValue);
         }
         return 0;
      }
      
      private function initView() : void
      {
         _digBtn = ComponentFactory.Instance.creatComponentByStylename("treasuremap.TreasureMapUseFrame.DigBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("treasuremap.TreasureMapUseFrame.helpBtn");
         _smallMapContainer = ComponentFactory.Instance.creatCustomObject("treasuremap.TreasureMapUseFrame.Container");
         _bg = ComponentFactory.Instance.creatComponentByStylename("treasuremap.TreasureMapUseFrame.mapBg");
         _checkMap = ComponentFactory.Instance.creatComponentByStylename("treasuremap.TreasureMapUseFrame.CheckMap");
         _checkMap.htmlText = LanguageMgr.GetTranslation("map.internals.view.treasuremap.TreasureMapUseFrame.CheckMapTxt");
         _checkMap.mouseEnabled = true;
         _helpBtn.tipData = LanguageMgr.GetTranslation("treasuremap.treasureMap.helpTipData");
         addToContent(_digBtn);
         addToContent(_helpBtn);
         addToContent(_smallMapContainer);
         addToContent(_bg);
         addToContent(_checkMap);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(_smallMapContainer);
         ObjectUtils.disposeObject(_flag);
         _flag = null;
         ObjectUtils.disposeObject(_smallMap);
         _smallMap = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_digBtn);
         _digBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         if(_digBtn)
         {
            _digBtn.addEventListener("click",__digBtnClickHandler);
         }
         GoodsManager.instance.addEventListener("DELETE_TREASURE_MAP",__deleteTreasureMapHandler);
         _checkMap.addEventListener("click",__checkMapClickHandler);
         model.addEventListener("TREASURE_INFO_UPDATE",__treasureInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         if(_digBtn)
         {
            _digBtn.removeEventListener("click",__digBtnClickHandler);
         }
         GoodsManager.instance.removeEventListener("DELETE_TREASURE_MAP",__deleteTreasureMapHandler);
         _checkMap.removeEventListener("click",__checkMapClickHandler);
         model.removeEventListener("TREASURE_INFO_UPDATE",__treasureInfoUpdateHandler);
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("treasuremap.TreasureMapUseFrame.HelpFrame");
         _loc2_.show();
      }
      
      private function __digBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc6_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc5_:String = null;
         var _loc4_:String = null;
         if(checkScene())
         {
            SimpleAlertHelper.instance.data = [digBtnAlertCallBack];
            _loc6_ = LanguageMgr.GetTranslation("map.internals.view.treasuremap.TreasureMapUseFrame.digBtnAlertTxt3",_digPointsCost,4);
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("map.internals.view.treasuremap.TreasureMapUseFrame.digBtnAlertTitle");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc2_,_loc3_,true,true,false,2,"USEBINDPOINT_ALERT");
         }
         else
         {
            _loc4_ = LanguageMgr.GetTranslation("map.internals.view.treasuremap.TreasureMapUseFrame.digBtnAlertTxt2");
            MessageTipManager.instance().show(_loc4_);
         }
      }
      
      private function checkScene() : Boolean
      {
         var _loc2_:int = 0;
         var _loc1_:String = SceneManager.instance.currentType;
         switch(_loc1_)
         {
            case "SPACE_SCENE":
               return true;
            case "CAMPAIGN_MAP_SCENE":
               if(CampaignManager.instance.mapModel)
               {
                  _loc2_ = int(CampaignManager.instance.mapModel.mapId);
                  if(WorldBossHelper.checkPetLand(_loc2_))
                  {
                     return true;
                  }
               }
         }
         return false;
      }
      
      private function setBtnEnabled() : void
      {
         if(model.rewardCount >= model.rewardMax)
         {
            _digBtn.enable = false;
         }
         else
         {
            _digBtn.enable = true;
         }
      }
      
      private function digBtnAlertCallBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(param1)
         {
            if(_info)
            {
               _loc3_ = int(playerInfo.point);
               if(param2)
               {
                  _loc3_ += playerInfo.giftToken;
               }
               if(_loc3_ >= _digPointsCost)
               {
                  TreasureMapSocketOutManager.sendDigTreasureMap(_info.pos,param2);
               }
               else
               {
                  RechargeAlertMannager.show();
               }
            }
         }
      }
      
      private function __deleteTreasureMapHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info as GoodsInfo;
         if(_loc2_ == info)
         {
            dispose();
         }
      }
      
      private function __checkMapClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!inSpaceScene && !inPetLand && !inMineral)
         {
            _loc2_ = LanguageMgr.GetTranslation("map.internals.view.treasuremap.TreasureMapUseFrame.CheckMapTipTxt");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         if(inSpaceScene)
         {
            FrameControllerManager.instance.openControllerByInfo("space",1);
         }
         else if(inPetLand)
         {
            FrameControllerManager.instance.openControllerByInfo("space",3);
         }
         else if(inMineral)
         {
            FrameControllerManager.instance.openControllerByInfo("space",4);
         }
         __treasureInfoUpdateHandler(null);
      }
      
      private function get inSpaceScene() : Boolean
      {
         if(SceneManager.instance.currentType == "SPACE_SCENE")
         {
            return true;
         }
         return false;
      }
      
      private function get inPetLand() : Boolean
      {
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE" && Boolean(WorldBossHelper.checkPetLand(CampaignManager.instance.mapId)))
         {
            return true;
         }
         return false;
      }
      
      private function get inMineral() : Boolean
      {
         if(SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE" && Boolean(WorldBossHelper.checkMineral(CampaignManager.instance.mapId)))
         {
            return true;
         }
         return false;
      }
      
      private function __treasureInfoUpdateHandler(param1:TreasureMapEvent) : void
      {
         if(model.mapFrameOpened)
         {
            _rect.width = 1159;
         }
         else
         {
            _rect.width = 455;
         }
         x = (StageReferance.gameStageWidth - _rect.width) / 2;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
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
      
      public function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get model() : TreasureMapModel
      {
         return TreasureMapManager.instance.model;
      }
      
      public function get info() : GoodsInfo
      {
         return _info;
      }
      
      public function set info(param1:GoodsInfo) : void
      {
         _info = param1;
         if(_info)
         {
            analyzeTreasureMap();
            titleText = _mapName;
            _smallMap = ComponentFactory.Instance.creatBitmap("asset.treasuremap.map" + _mapTile);
            _flag = ComponentFactory.Instance.creatBitmap("asset.treasuremap.flag");
            _flag.x = _smallMapContainer.x + _flagPosX - _flag.width / 2;
            _flag.y = _smallMapContainer.y + _flagPosY - _flag.height / 2;
            _smallMapContainer.addChild(_smallMap);
            addToContent(_flag);
         }
         setBtnEnabled();
      }
      
      private function analyzeTreasureMap() : void
      {
         var _loc7_:MapTemplate = TempleteManager.instance.mapTemplateCate.getTemplateByID(_info.randomSkill1);
         var _loc6_:int = Math.ceil(_loc7_.Width / 3);
         var _loc8_:int = Math.ceil(_loc7_.Height / 3);
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(0 < _info.randomSkill2 && _info.randomSkill2 < _loc6_)
         {
            _loc1_ = 1;
            _loc2_ = int(_info.randomSkill2);
         }
         else if(_loc6_ < _info.randomSkill2 && _info.randomSkill2 < _loc6_ * 2)
         {
            _loc1_ = 2;
            _loc2_ = _info.randomSkill2 - _loc6_;
         }
         else if(_loc6_ * 2 < _info.randomSkill2 && _info.randomSkill2 < _loc7_.Width)
         {
            _loc1_ = 3;
            _loc2_ = _info.randomSkill2 - _loc6_ * 2;
         }
         if(0 < _info.randomSkill3 && _info.randomSkill3 < _loc8_)
         {
            _loc3_ = 1;
            _loc4_ = int(_info.randomSkill3);
         }
         else if(_loc8_ < _info.randomSkill3 && _info.randomSkill3 < _loc8_ * 2)
         {
            _loc3_ = 2;
            _loc4_ = _info.randomSkill3 - _loc8_;
         }
         else if(_loc8_ * 2 < _info.randomSkill3 && _info.randomSkill3 < _loc7_.Height)
         {
            _loc3_ = 3;
            _loc4_ = _info.randomSkill3 - _loc8_ * 2;
         }
         _loc5_ = (_loc3_ - 1) * 3 + _loc1_;
         _mapName = _loc7_.MapName;
         _mapTile = _info.randomSkill1.toString() + _loc5_.toString();
         _flagPosX = _loc2_ * 1000 / _loc7_.Width;
         _flagPosY = _loc4_ * 1000 / _loc7_.Height;
      }
      
      public function show() : void
      {
         var _loc2_:NewGuildFrame = null;
         var _loc1_:Object = null;
         _rect = new Rectangle(0,0,455,491);
         model.useFrameOpened = true;
         model.commit();
         __treasureInfoUpdateHandler(null);
         LayerManager.Instance.addToLayer(this,3,true,true);
         if(!model.isFirstUse && !SharedManager.instance.isUsedTreaSureMap)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("core.newGuildHelpFrame");
            _loc1_ = {};
            _loc1_.frameName = "treasuremap.NewGuildFrame";
            _loc1_.index = 1;
            _loc2_.data = _loc1_;
            _loc2_.show();
            SharedManager.instance.isUsedTreaSureMap = true;
            SharedManager.instance.saveIsUsedTreasureMap();
         }
      }
      
      override public function dispose() : void
      {
         model.useFrameOpened = false;
         model.commit();
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

