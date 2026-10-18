package marry.income
{
   import bag.events.BagEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.TreasureMapEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.TreasureMapManager;
   import map.campaign.CampaignManager;
   import map.internals.data.template.MapTemplate;
   import mvc.ModuleFrameInfo;
   import mvc.module.marry.MarrySender;
   import mvc.module.treasuremap.TreasureMapModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.WorldBossHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class MarryTaskMapFrame extends Frame implements IManualSize
   {
      
      private const FRAME_WIDTH:int = 455;
      
      private const FRAME_HEIGHT:int = 506;
      
      private const GROUP_WIDTH:int = 1159;
      
      private var _rect:Rectangle;
      
      private var _opBtn:IconButton;
      
      private var _shipe:MutipleImage;
      
      private var _checkMap:FilterFrameText;
      
      private var _smallMapContainer:Sprite;
      
      private var _smallMap:Bitmap;
      
      private var _flag:Bitmap;
      
      private var _info:GoodsInfo;
      
      private var _mapTile:String;
      
      private var _flagPosX:int;
      
      private var _flagPosY:int;
      
      private var _mapName:String;
      
      private var _digPointsCost:int = 0;
      
      public function MarryTaskMapFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         if(_rect == null)
         {
            _rect = new Rectangle(0,0,455,506);
         }
         return _rect;
      }
      
      override public function get groups() : Array
      {
         return ["TREASURE_MAP_GROUP"];
      }
      
      private function initView() : void
      {
         _opBtn = ComponentFactory.Instance.creatComponentByStylename("MarryTaskMapFrame.opBtn");
         _shipe = ComponentFactory.Instance.creatComponentByStylename("MarryTaskMapFrame.shape");
         _checkMap = ComponentFactory.Instance.creatComponentByStylename("MarryTaskMapFrame.CheckMap");
         _flag = ComponentFactory.Instance.creatBitmap("asset.marry.taskMapFlag");
         _checkMap.htmlText = LanguageMgr.GetTranslation("map.internals.view.treasuremap.TreasureMapUseFrame.CheckMapTxt");
         _smallMapContainer = new Sprite();
         addToContent(_opBtn);
         addToContent(_smallMapContainer);
         addToContent(_shipe);
         addToContent(_checkMap);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _opBtn.addEventListener("click",__opBtnHandler);
         _checkMap.addEventListener("click",__checkMapClickHandler);
         treasureModel.addEventListener("TREASURE_INFO_UPDATE",__treasureInfoUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_MARRY_TASK_MAP",__deleteMarryTaskMapHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_opBtn)
         {
            _opBtn.removeEventListener("click",__opBtnHandler);
         }
         if(_checkMap)
         {
            _checkMap.removeEventListener("click",__checkMapClickHandler);
         }
         treasureModel.removeEventListener("TREASURE_INFO_UPDATE",__treasureInfoUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_MARRY_TASK_MAP",__deleteMarryTaskMapHandler);
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
      
      private function __treasureInfoUpdateHandler(param1:TreasureMapEvent) : void
      {
         if(treasureModel.mapFrameOpened)
         {
            _rect.width = 1159;
         }
         else
         {
            _rect.width = 455;
         }
         x = (StageReferance.gameStageWidth - _rect.width) / 2;
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
      
      private function get treasureModel() : TreasureMapModel
      {
         return TreasureMapManager.instance.model;
      }
      
      private function __opBtnHandler(param1:MouseEvent) : void
      {
         if(info && TreasureMapManager.instance.checkTreasureMap(info))
         {
            MarrySender.useTaskGoods(info.pos);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function __deleteMarryTaskMapHandler(param1:BagEvent) : void
      {
         var _loc2_:GoodsInfo = param1.info as GoodsInfo;
         if(_loc2_ == info)
         {
            dispose();
         }
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
            CheckUIModuleUtil.instance.tryCall("treasuremap",__addMapHandler);
         }
      }
      
      private function __addMapHandler() : void
      {
         if(_info)
         {
            titleText = _mapName;
            _smallMap = ComponentFactory.Instance.creatBitmap("asset.treasuremap.map" + _mapTile);
            _flag.x = _smallMapContainer.x + _flagPosX - _flag.width / 2;
            _flag.y = _smallMapContainer.y + _flagPosY - _flag.height / 2;
            if(_smallMap)
            {
               _smallMapContainer.addChild(_smallMap);
            }
            addToContent(_flag);
            if(_info.templateInfo.Property1 == 1)
            {
               _opBtn.iconStyle = "asset.marry.taskBtnIcon2";
               _opBtn.iconInnerRectString = "31,93,17,25,13";
            }
            else if(_info.templateInfo.Property1 == 2)
            {
               _opBtn.iconStyle = "asset.marry.taskBtnIcon1";
               _opBtn.iconInnerRectString = "50,56,17,25,13";
            }
         }
         else
         {
            dispose();
         }
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         treasureModel.useFrameOpened = true;
         _rect = new Rectangle(0,0,455,506);
         __treasureInfoUpdateHandler(null);
         if(param1)
         {
            info = param1.frameData as GoodsInfo;
         }
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         treasureModel.useFrameOpened = false;
         removeEvent();
         ObjectUtils.disposeAllChildren(_smallMapContainer);
         ObjectUtils.disposeObject(_flag);
         _flag = null;
         ObjectUtils.disposeObject(_smallMap);
         _smallMap = null;
         ObjectUtils.disposeObject(_opBtn);
         _opBtn = null;
         ObjectUtils.disposeObject(_shipe);
         _shipe = null;
         ObjectUtils.disposeObject(_checkMap);
         _checkMap = null;
         _info = null;
         _smallMapContainer = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

