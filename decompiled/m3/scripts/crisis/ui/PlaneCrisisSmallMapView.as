package crisis.ui
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.module.crisis.PlaneCrisisEventType;
   import mvc.module.crisis.PlaneCrisisModel;
   import mvc.module.crisis.PlaneCrisisNodeInfo;
   import mvc.module.crisis.PlaneCrisisPlayerInfo;
   import yishi.datas.templates.PlaneCrisisTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlaneCrisisManager;
   import yishi.manager.TempleteManager;
   
   public class PlaneCrisisSmallMapView extends Sprite implements IEnterFrame
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _titleTxt:FilterFrameText;
      
      private var _mapBit:Bitmap;
      
      private var _container:Sprite;
      
      private var _roleDic:Dictionary;
      
      private var _scaleMapX:Number = 1;
      
      private var _scaleMapY:Number = 1;
      
      private var _offsetX:int;
      
      private var _offsetY:int;
      
      private var _bossView:Bitmap;
      
      private var _nodeDic:Dictionary;
      
      public function PlaneCrisisSmallMapView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _nodeDic = new Dictionary();
         _roleDic = new Dictionary();
         _back = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.smallBack");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("ui.planecrisis.samllMapTitleTxt");
         _mapBit = new Bitmap();
         _container = new Sprite();
         _container.x = 37;
         _container.y = 20;
         addChild(_back);
         addChild(_container);
         addChild(_titleTxt);
         _container.addChild(_mapBit);
         _offsetX = model.mapOffsetX;
         _offsetY = model.mapOffsetY;
         _titleTxt.text = LanguageMgr.GetTranslation("planeCrisis.smallTitile");
         loadMapImg();
         LayerManager.Instance.addToLayer(this,4);
      }
      
      private function get model() : PlaneCrisisModel
      {
         return PlaneCrisisManager.Instance.model;
      }
      
      private function loadMapImg() : void
      {
         var _loc1_:String = PathManager.getPlaneCrisisSmallMap(model.currMapId);
         LoaderManagerII.instance.load(_loc1_,2,0,onLoadComplete);
      }
      
      private function onLoadComplete(param1:LoaderInfo, param2:Object) : void
      {
         var _loc3_:BitmapData = null;
         if(param2)
         {
            ObjectUtils.disposeObject(_mapBit.bitmapData);
            _loc3_ = (param2 as Bitmap).bitmapData;
            _mapBit.bitmapData = _loc3_;
            _scaleMapX = _mapBit.width / (model.width - model.mapOffsetX * 2);
            _scaleMapY = _mapBit.height / (model.height - model.mapOffsetY * 2);
            resizeHandler();
            initNodes();
            initShowBoss();
            initRoles();
         }
      }
      
      private function initShowBoss() : void
      {
         for each(var _loc1_:PlaneCrisisNodeInfo in model.nodeInfoDic)
         {
            if(_loc1_.eventType == PlaneCrisisEventType.END_BOSS && Boolean(_loc1_.isOpen))
            {
               creatBossView(_loc1_.nodeId);
               break;
            }
         }
      }
      
      private function initEvent() : void
      {
         EnterFrameManager.instance.registeEnterFrame(this);
         addEventListener("addedToStage",addToStageHandler);
         StageReferance.stage.addEventListener("resize",resizeHandler);
         model.addEventListener("PlaneCrisisEventType.addArmy",addArmyHandler);
         model.addEventListener("PlaneCrisisEventType.removeArmy",removeArmyHandler);
         NotificationManager.instance.addEventListener("PlaneCrisisEventType.showBossToSmall",showBossHandler);
         NotificationManager.instance.addEventListener("PlaneCrisisEventType.updateSmallPoint",updatePointHandler);
      }
      
      private function removeEvent() : void
      {
         EnterFrameManager.instance.unRegisteEnterFrame(this);
         removeEventListener("addedToStage",addToStageHandler);
         StageReferance.stage.removeEventListener("resize",resizeHandler);
         model.removeEventListener("PlaneCrisisEventType.addArmy",addArmyHandler);
         model.removeEventListener("PlaneCrisisEventType.removeArmy",removeArmyHandler);
         NotificationManager.instance.removeEventListener("PlaneCrisisEventType.showBossToSmall",showBossHandler);
         NotificationManager.instance.removeEventListener("PlaneCrisisEventType.updateSmallPoint",updatePointHandler);
      }
      
      private function updatePointHandler(param1:NotificationEvent) : void
      {
         var _loc3_:Bitmap = null;
         var _loc2_:PlaneCrisisNodeInfo = param1.data as PlaneCrisisNodeInfo;
         if(_loc2_.isPick)
         {
            _loc3_ = _nodeDic[_loc2_.nodeId];
            if(_loc3_ != null)
            {
               _loc3_.bitmapData = null;
            }
         }
      }
      
      private function showBossHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         creatBossView(_loc2_);
      }
      
      private function creatBossView(param1:int) : void
      {
         if(_bossView != null)
         {
            return;
         }
         var _loc2_:PlaneCrisisTempInfo = TempleteManager.instance.planeCrisisTempCate.getNodeTempInfo(model.currMapId,param1);
         if(_loc2_ != null)
         {
            _bossView = ComponentFactory.Instance.creatBitmap("asset.planecrisis.SBoss");
            _bossView.x = (_loc2_.X - _offsetX) * _scaleMapX - _bossView.width * 0.5;
            _bossView.y = (_loc2_.Y - _offsetY) * _scaleMapY - _bossView.height * 0.5;
            _container.addChild(_bossView);
         }
      }
      
      private function addToStageHandler(param1:Event) : void
      {
         resizeHandler();
      }
      
      private function addArmyHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Bitmap = null;
         var _loc3_:PlaneCrisisPlayerInfo = param1.data as PlaneCrisisPlayerInfo;
         if(_loc3_ != null)
         {
            _loc2_ = _roleDic[_loc3_.userId];
            if(_loc2_ == null)
            {
               _loc2_ = createArmy(_loc3_);
               _container.addChild(_loc2_);
               _roleDic[_loc3_.userId] = _loc2_;
            }
         }
      }
      
      private function removeArmyHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Bitmap = null;
         var _loc3_:PlaneCrisisPlayerInfo = param1.data as PlaneCrisisPlayerInfo;
         if(_loc3_ != null)
         {
            _loc2_ = _roleDic[_loc3_.userId];
            if(_loc2_ != null)
            {
               delete _roleDic[_loc3_.userId];
               ObjectUtils.disposeObject(_loc2_);
            }
         }
      }
      
      private function resizeHandler(param1:Event = null) : void
      {
         this.x = StageReferance.stage.stageWidth - 220;
         this.y = 0;
      }
      
      private function createArmy(param1:PlaneCrisisPlayerInfo) : Bitmap
      {
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.planecrisis.SColor" + param1.color);
         var _loc3_:PlaneCrisisTempInfo = TempleteManager.instance.planeCrisisTempCate.getNodeTempInfo(model.currMapId,param1.standNodeId);
         if(_loc3_)
         {
            _loc2_.x = (_loc3_.X - _offsetX) * _scaleMapX - _loc2_.width * 0.5;
            _loc2_.y = (_loc3_.Y - _offsetY) * _scaleMapY - _loc2_.height * 0.5;
         }
         return _loc2_;
      }
      
      private function initRoles() : void
      {
         var _loc1_:Bitmap = null;
         for each(var _loc2_:PlaneCrisisPlayerInfo in model.planeCrisisInfoDic)
         {
            if(_loc2_ != null)
            {
               _loc1_ = _roleDic[_loc2_.userId];
               if(_loc1_ == null)
               {
                  _loc1_ = createArmy(_loc2_);
                  _container.addChild(_loc1_);
                  _roleDic[_loc2_.userId] = _loc1_;
               }
            }
         }
      }
      
      private function initNodes() : void
      {
         var _loc5_:PlaneCrisisNodeInfo = null;
         var _loc6_:Bitmap = null;
         if(model == null)
         {
            return;
         }
         var _loc2_:Array = TempleteManager.instance.planeCrisisTempCate.getOneMapNodes(model.currMapId);
         var _loc4_:BitmapData = PlaneCrisisComBitData.Instance.smallLight;
         var _loc1_:int = 0;
         switch(int(model.currMapId) - 1)
         {
            case 0:
               _loc1_ = 0;
               break;
            case 1:
               _loc1_ = 3;
               break;
            case 2:
               _loc1_ = 3;
         }
         for each(var _loc3_:PlaneCrisisTempInfo in _loc2_)
         {
            _loc6_ = new Bitmap();
            _loc6_.bitmapData = _loc4_;
            _loc6_.x = (_loc3_.X - _offsetX) * _scaleMapX - _loc6_.width * 0.5;
            _loc6_.y = (_loc3_.Y - _offsetY) * _scaleMapY - _loc6_.height * 0.5 + _loc1_;
            _container.addChild(_loc6_);
            _nodeDic[_loc3_.NodeId] = _loc6_;
            _loc5_ = model.nodeInfoDic[_loc3_.NodeId];
            if(_loc5_ != null && Boolean(_loc5_.isPick))
            {
               _loc6_.bitmapData = null;
            }
         }
      }
      
      public function enterFrame() : void
      {
         var _loc1_:Bitmap = null;
         var _loc2_:PlaneCrisisArmyView = null;
         if(model == null)
         {
            trace("planecrisissmallmap:资源释放错误");
            return;
         }
         for(var _loc3_:String in _roleDic)
         {
            _loc1_ = _roleDic[_loc3_];
            _loc2_ = model.armyViewDic[_loc3_];
            if(_loc1_ != null && _loc2_ != null)
            {
               _loc1_.x = (_loc2_.x - _offsetX) * _scaleMapX - _loc1_.width * 0.5;
               _loc1_.y = (_loc2_.y - _offsetY) * _scaleMapY - _loc1_.height * 0.5;
            }
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:Bitmap in _roleDic)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _roleDic = null;
         for each(var _loc2_:Bitmap in _nodeDic)
         {
            ObjectUtils.disposeObject(_loc2_);
         }
         _nodeDic = null;
         ObjectUtils.disposeObject(_mapBit);
         _mapBit = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_titleTxt);
         _titleTxt = null;
         ObjectUtils.disposeObject(_bossView);
         _bossView = null;
         ObjectUtils.disposeAllChildren(_container);
         _container = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

