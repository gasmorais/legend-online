package water.view
{
   import com.pickgliss.loader.ModuleLoader;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.farm.TreeUpdateRsp;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.data.FarmInfo;
   import farm.event.FarmEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.BuildingSocketOutManager;
   import water.data.WaterTreeModel;
   import water.events.WaterEvent;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.CursorManagerII;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.manager.WaterManager;
   import yishi.service.managers.SocketManager;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.SimpleMovie;
   
   public class WaterViewContainer extends Sprite implements Disposeable
   {
      
      private var _treeContainer:Sprite;
      
      private var _tree:Bitmap;
      
      private var _treeEffect:MovieClip;
      
      private var _waterEffect:SimpleMovie;
      
      private var _waterAlert:SimpleMovie;
      
      private var _pickEffect:SimpleMovie;
      
      private var _pickCircleDisAppear:SimpleMovie;
      
      private var _pickProgress:SimpleMovie;
      
      private var _pickEffectAppear:SimpleMovie;
      
      private var _pickEffectLoop:SimpleMovie;
      
      private var _pickEffectDisAppear:SimpleMovie;
      
      private var _pickAlert:SimpleMovie;
      
      private var _waterImg:Bitmap;
      
      private var _pickImg:Bitmap;
      
      private var _hasOperEffect:MovieClip;
      
      private var _pickTime:TimeDownView;
      
      private var _waterTime:TimeDownView;
      
      private var _waterMouseFlag:Boolean;
      
      private var _pickMouoseFlag:Boolean;
      
      private var _waterEnable:Boolean;
      
      private var _pickEnable:Boolean;
      
      private var _treeNameBg:ScaleBitmapImage;
      
      private var _treeNameTxt:FilterFrameText;
      
      private var _filter:UIFilter;
      
      private var _buildFilter:SimpleBuildingFilter;
      
      private var _pickResultArr:Array = [];
      
      private var _resultCount:int = 1;
      
      private var _progressDis:SimpleMovie;
      
      public function WaterViewContainer()
      {
         super();
         init();
         initEvent();
      }
      
      private function get farmModel() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      private function get model() : WaterTreeModel
      {
         return WaterManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function init() : void
      {
         _treeContainer = new Sprite();
         _treeContainer.x = 3;
         _treeContainer.y = 13;
         addChild(_treeContainer);
         _treeNameBg = ComponentFactory.Instance.creatComponentByStylename("farm.TreeNameBg");
         _treeNameTxt = ComponentFactory.Instance.creatComponentByStylename("farm.TreeNameTxt");
         _hasOperEffect = ComponentFactory.Instance.creatCustomObject("farm.TreeHasOperEffect");
         _waterImg = ComponentFactory.Instance.creatBitmap("asset.water.WaterStateImg");
         _pickImg = ComponentFactory.Instance.creatBitmap("asset.water.PickStateImg");
         _pickTime = ComponentFactory.Instance.creatComponentByStylename("Tips.TimeDownView");
         _waterTime = ComponentFactory.Instance.creatComponentByStylename("Tips.TimeDownView");
         _pickTime.x = 90;
         _pickTime.y = 172;
         _waterTime.x = 90;
         _waterTime.y = 229;
         _hasOperEffect.mouseEnabled = _hasOperEffect.mouseChildren = false;
         _treeNameBg.mouseEnabled = _treeNameBg.mouseChildren = false;
         _treeNameTxt.text = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command07");
         addChild(_pickTime);
         addChild(_waterTime);
         addChild(_treeNameBg);
         addChild(_treeNameTxt);
         _filter = new UIFilter();
         _buildFilter = new SimpleBuildingFilter();
      }
      
      private function uninit() : void
      {
         __cleanEffectHandler(null);
         _treeContainer = null;
         if(_hasOperEffect)
         {
            _hasOperEffect.stop();
         }
         _hasOperEffect = null;
         _pickResultArr = null;
         _waterImg = null;
         _pickImg = null;
         _filter = null;
         _buildFilter = null;
      }
      
      private function cleanHasOperEffect() : void
      {
         if(_hasOperEffect)
         {
            _hasOperEffect.stop();
         }
         if(_waterImg.parent)
         {
            _waterImg.parent.removeChild(_waterImg);
         }
         if(_pickImg.parent)
         {
            _pickImg.parent.removeChild(_pickImg);
         }
         if(_hasOperEffect.parent)
         {
            _hasOperEffect.parent.removeChild(_hasOperEffect);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("rollOver",__rollOverHandler);
         addEventListener("rollOut",__rollOutHandler);
         addEventListener("click",__mouseClickHandler);
         _treeContainer.addEventListener("mouseOver",__onTreeOver);
         _treeContainer.addEventListener("mouseOut",__onTreeOut);
         _waterTime.addEventListener("timerDown_complete",__timeCompleteHandler);
         _pickTime.addEventListener("timerDown_complete",__timeCompleteHandler);
         farmModel.addEventListener("SELECTED_CHANGE",__selectedFarmChangeHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 146,__message);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 106,__pickResultHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4189,__pickHavestHandler);
         WaterManager.instance.addEventListener("UPDATA_WATER_STATE",__updateWaterStateHandler);
         WaterManager.instance.addEventListener("TREE_UPDATE",__treeInfoUpdateHandler);
         NotificationManager.instance.addEventListener("CLEAN_WATER_EFFECT",__cleanEffectHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("rollOver",__rollOverHandler);
         removeEventListener("rollOut",__rollOutHandler);
         removeEventListener("click",__mouseClickHandler);
         _treeContainer.removeEventListener("mouseOver",__onTreeOver);
         _treeContainer.removeEventListener("mouseOut",__onTreeOut);
         farmModel.removeEventListener("SELECTED_CHANGE",__selectedFarmChangeHandler);
         _waterTime.removeEventListener("timerDown_complete",__timeCompleteHandler);
         _pickTime.removeEventListener("timerDown_complete",__timeCompleteHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 146,__message);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 106,__pickResultHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4189,__pickHavestHandler);
         WaterManager.instance.removeEventListener("TREE_UPDATE",__treeInfoUpdateHandler);
         WaterManager.instance.removeEventListener("UPDATA_WATER_STATE",__updateWaterStateHandler);
         NotificationManager.instance.removeEventListener("CLEAN_WATER_EFFECT",__cleanEffectHandler);
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         (param1.currentTarget as TimeDownView).visible = false;
         updateState();
      }
      
      private function __selectedFarmChangeHandler(param1:FarmEvent) : void
      {
         refreshTreeView();
      }
      
      private function __treeInfoUpdateHandler(param1:WaterEvent) : void
      {
         refreshTree();
         clean();
         refreshWaterState();
         refreshPickState();
         updateState();
      }
      
      private function __updateWaterStateHandler(param1:WaterEvent) : void
      {
         if(model.currentSelectedTreeInfo)
         {
            updateState();
         }
      }
      
      private function __onTreeOver(param1:MouseEvent) : void
      {
         _buildFilter.setGlowFilter(_treeContainer);
      }
      
      private function __onTreeOut(param1:MouseEvent) : void
      {
         _buildFilter.setBuildingOutFilter(_treeContainer);
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         if(DragManager.getInstance().isDraging || Boolean(DoubleClickManager.Instance.isClicking))
         {
            return;
         }
         if(_pickMouoseFlag)
         {
            CursorManagerII.instance.showCursorByType("PICK_CURSOR");
         }
         else if(_waterMouseFlag)
         {
            CursorManagerII.instance.showCursorByType("WATER_CURSOR");
         }
         else
         {
            CursorManagerII.instance.resetCursor();
         }
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         CursorManagerII.instance.resetCursor();
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = "";
         if(_pickMouoseFlag)
         {
            if(_pickEnable)
            {
               BuildingSocketOutManager.pickFruits(0);
            }
            else
            {
               if(model.currentSelectedTreeInfo.fruitCount < 1)
               {
                  _loc2_ = LanguageMgr.GetTranslation("buildings.water.view.WaterViewContainer.command01");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               if(model.currentSelectedTreeInfo.left_pickTime > 0)
               {
                  _loc2_ = LanguageMgr.GetTranslation("buildings.water.view.WaterViewContainer.command02");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
            }
            return;
         }
         if(_waterMouseFlag)
         {
            if(_waterEnable)
            {
               SoundManager.instance.play("021",true);
               BuildingSocketOutManager.water(model.currentSelectedTreeInfo.userId);
            }
            else
            {
               if(model.currentSelectedTreeInfo.waterCount >= TempleteManager.instance.getTemplateByLevelAndType(farmModel.curSelectedFarmInfo.grade,7).Data)
               {
                  _loc2_ = LanguageMgr.GetTranslation("buildings.water.view.WaterViewContainer.command03");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               if(!WaterManager.instance.isWatered(model.currentSelectedTreeInfo.userId))
               {
                  _loc2_ = LanguageMgr.GetTranslation("buildings.water.view.WaterViewContainer.command04");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
               if(model.currentSelectedTreeInfo.left_time > 0)
               {
                  _loc2_ = LanguageMgr.GetTranslation("buildings.water.view.WaterViewContainer.command05");
                  MessageTipManager.instance().show(_loc2_);
                  return;
               }
            }
         }
      }
      
      private function refreshTreeView() : void
      {
         refreshTree();
         clean();
         refreshWaterState();
         refreshPickState();
         updateState();
      }
      
      private function refreshTree() : void
      {
         var _loc2_:DisplayObject = null;
         var _loc1_:Class = null;
         var _loc3_:Object = null;
         while(_treeContainer.numChildren > 0)
         {
            _loc2_ = _treeContainer.removeChildAt(0);
            ObjectUtils.disposeObject(_loc2_);
         }
         if(!model.currentSelectedTreeInfo.notHasTree)
         {
            _loc1_ = ModuleLoader.getDefinition("asset.farm.Tree_1") as Class;
            _loc3_ = ModuleLoader.getDefinition("asset.farm.TreeEffect_1");
         }
         else
         {
            _loc1_ = ModuleLoader.getDefinition("asset.farm.Tree_1") as Class;
            _loc3_ = ModuleLoader.getDefinition("asset.farm.TreeEffect_1");
         }
         _tree = new Bitmap(new _loc1_(536,389) as BitmapData);
         _tree.smoothing = true;
         _treeEffect = new _loc3_() as MovieClip;
         _treeEffect.mouseEnabled = _treeEffect.mouseChildren = false;
         _treeEffect.x = 124;
         _treeEffect.y = 147;
         _treeContainer.addChild(_tree);
         _treeContainer.addChild(_treeEffect);
      }
      
      private function clean() : void
      {
         _waterTime.visible = false;
         _pickTime.visible = false;
         _treeEffect.stop();
         _treeEffect.visible = false;
         _pickMouoseFlag = false;
         _waterMouseFlag = false;
         cleanHasOperEffect();
      }
      
      private function refreshWaterState() : void
      {
         var _loc1_:UpgradeTemplateInfo = null;
         if(model.currentSelectedTreeInfo.notHasTree)
         {
            return;
         }
         if(WaterManager.instance.isWatered(model.currentSelectedTreeInfo.userId))
         {
            _loc1_ = TempleteManager.instance.getTemplateByLevelAndType(farmModel.curSelectedFarmInfo.grade,7);
            if(model.currentSelectedTreeInfo.userId == thane.userId && (!_loc1_ || model.currentSelectedTreeInfo.waterCount >= _loc1_.Data))
            {
               return;
            }
            _filter.setNormalFilter(_hasOperEffect["hasOperBox"]);
            _hasOperEffect["hasOperBox"].play();
            _hasOperEffect["hasOperBox"].visible = true;
            if(model.currentSelectedTreeInfo.userId == thane.userId && model.currentSelectedTreeInfo.left_time > 0)
            {
               _waterTime.visible = true;
               _waterTime.timeCount = model.currentSelectedTreeInfo.left_time;
               _filter.setGrayFilter(_hasOperEffect["hasOperBox"]);
               _hasOperEffect["hasOperBox"].stop();
               if(_waterEffect)
               {
                  _waterTime.visible = false;
                  _hasOperEffect["hasOperBox"].visible = false;
               }
            }
            cleanHasOperEffect();
            _hasOperEffect.gotoAndStop("hasOperEffect");
            _hasOperEffect["hasOperBox"]["box"].addChild(_waterImg);
            addChild(_hasOperEffect);
            _waterMouseFlag = true;
         }
      }
      
      private function refreshPickState() : void
      {
         if(model.currentSelectedTreeInfo.fruitCount > 0)
         {
            _treeEffect.play();
            _treeEffect.visible = true;
            if(model.currentSelectedTreeInfo.userId == thane.userId)
            {
               cleanHasOperEffect();
               _filter.setNormalFilter(_hasOperEffect["hasOperBox"]);
               _hasOperEffect["hasOperBox"].play();
               _hasOperEffect.gotoAndStop("hasOperEffect");
               _hasOperEffect["hasOperBox"]["box"].addChild(_pickImg);
               addChild(_hasOperEffect);
               _pickMouoseFlag = true;
               _hasOperEffect["hasOperBox"].visible = true;
               if(model.currentSelectedTreeInfo.left_pickTime > 0)
               {
                  _pickTime.visible = true;
                  _pickMouoseFlag = false;
                  _pickTime.timeCount = model.currentSelectedTreeInfo.left_pickTime;
                  _filter.setGrayFilter(_hasOperEffect["hasOperBox"]);
                  _hasOperEffect["hasOperBox"].stop();
                  if(_waterEffect)
                  {
                     _pickTime.visible = false;
                     _hasOperEffect["hasOperBox"].visible = false;
                  }
               }
            }
         }
      }
      
      private function updateState() : void
      {
         if(model.currentSelectedTreeInfo)
         {
            _waterEnable = model.currentSelectedTreeInfo.canWater;
            _pickEnable = model.currentSelectedTreeInfo.canPick;
            if(_waterEnable || _pickEnable)
            {
               _filter.setNormalFilter(_hasOperEffect["hasOperBox"]);
               _hasOperEffect["hasOperBox"].play();
            }
         }
      }
      
      private function appearCallBack() : void
      {
         _pickEffectAppear = null;
         addChild(_pickEffectLoop);
      }
      
      private function __message(param1:SLGSocketEvent) : void
      {
         var _loc8_:int = 0;
         var _loc2_:Array = [];
         var _loc10_:PackageIn = param1.data as PackageIn;
         var _loc3_:TreeUpdateRsp = new TreeUpdateRsp();
         _loc3_ = _loc10_.readBody(_loc3_) as TreeUpdateRsp;
         var _loc6_:int = int(_loc3_.harvestMsg.length);
         if(_loc6_ == 0)
         {
            return;
         }
         this.mouseEnabled = false;
         this.mouseChildren = false;
         var _loc4_:Point = localToGlobal(new Point(110,128));
         _waterEffect = new SimpleMovie(ComponentFactory.Instance.creat("asset.water.WaterEffect"));
         _waterEffect.x = _loc4_.x;
         _waterEffect.y = _loc4_.y;
         _waterEffect.addEventListener("complete",__effectComplete);
         var _loc7_:MovieClip = ComponentFactory.Instance.creat("asset.core.AlertTxtEffect");
         _waterAlert = new SimpleMovie(_loc7_);
         _waterAlert.x = 50;
         _waterAlert.y = 150;
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc7_["content"]["mc" + (_loc8_ + 1)].txt.text = String(_loc3_.harvestMsg[_loc8_]);
            _loc7_["content"]["mc" + (_loc8_ + 1)].txt.setTextFormat(ComponentFactory.Instance.model.getSet("water.AlertStyle_t"));
            _loc8_++;
         }
         addChild(_waterAlert);
         LayerManager.Instance.addToLayer(_waterEffect,3);
         var _loc5_:FarmInfo = farmModel.curSelectedFarmInfo;
         if(!_loc5_ || Boolean(_loc3_.isUpGrade))
         {
            return;
         }
         var _loc9_:int = int(farmModel.expByOper(23));
         farmModel.myFarm.gp += _loc9_;
         if(_loc5_.userId != thane.userId)
         {
            farmModel.myFarm.dayGpFromFriend += _loc9_;
         }
      }
      
      private function __effectComplete(param1:Event) : void
      {
         if(!_waterEffect)
         {
            return;
         }
         if(model.currentSelectedTreeInfo.userId == thane.userId)
         {
            if(WaterManager.instance.isWatered(model.currentSelectedTreeInfo.userId) && model.currentSelectedTreeInfo.left_time > 0)
            {
               _waterTime.visible = true;
               _hasOperEffect["hasOperBox"].visible = true;
            }
            if(model.currentSelectedTreeInfo.fruitCount > 0 && model.currentSelectedTreeInfo.left_pickTime > 0)
            {
               _pickTime.visible = true;
               _hasOperEffect["hasOperBox"].visible = true;
            }
         }
         _waterEffect.removeEventListener("complete",__effectComplete);
         _waterEffect = null;
         _waterAlert = null;
         this.mouseEnabled = true;
         this.mouseChildren = true;
         updateState();
         if(hitTestPoint(StageReferance.stage.mouseX,StageReferance.stage.mouseY))
         {
            dispatchEvent(new MouseEvent("mouseOver"));
         }
      }
      
      private function __pickHavestHandler(param1:SLGSocketEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:Array = [];
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc3_:TreeUpdateRsp = new TreeUpdateRsp();
         _loc3_ = _loc7_.readBody(_loc3_) as TreeUpdateRsp;
         var _loc4_:int = int(_loc3_.harvestMsg.length);
         if(_loc4_ == 0)
         {
            return;
         }
         this.mouseEnabled = false;
         this.mouseChildren = false;
         var _loc5_:MovieClip = ComponentFactory.Instance.creat("asset.core.AlertTxtEffect");
         _waterAlert = new SimpleMovie(_loc5_);
         _waterAlert.x = 150;
         _waterAlert.y = 168;
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_["content"]["mc" + (_loc6_ + 1)].txt.text = String(_loc3_.harvestMsg[_loc6_]);
            _loc5_["content"]["mc" + (_loc6_ + 1)].txt.setTextFormat(ComponentFactory.Instance.model.getSet("water.AlertStyle_t"));
            _loc6_++;
         }
         addChild(_waterAlert);
         farmModel.myFarm.gp += farmModel.expByOper(24);
      }
      
      private function __pickResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc8_:int = 0;
         var _loc10_:PackageIn = param1.data as PackageIn;
         var _loc2_:TreeUpdateRsp = new TreeUpdateRsp();
         _loc2_ = _loc10_.readBody(_loc2_) as TreeUpdateRsp;
         var _loc5_:int = int(_loc2_.pickMsg.length);
         if(_loc5_ == 0)
         {
            return;
         }
         this.mouseEnabled = false;
         this.mouseChildren = false;
         _pickResultArr.splice(0,_pickResultArr.length);
         _loc8_ = 0;
         while(_loc8_ < _loc5_)
         {
            _pickResultArr.push(_loc2_.pickMsg[_loc8_]);
            _loc8_++;
         }
         var _loc4_:MovieClip = ComponentFactory.Instance.creat("asset.water.PickCircleAsset");
         _pickEffect = new SimpleMovie(_loc4_,null,0);
         _pickEffect.x = 137;
         _pickEffect.y = 143;
         var _loc7_:MovieClip = ComponentFactory.Instance.creat("asset.water.PickIconAppear");
         _pickEffectAppear = new SimpleMovie(_loc7_,appearCallBack);
         _pickEffectAppear.x = 187;
         _pickEffectAppear.y = 203;
         var _loc6_:MovieClip = ComponentFactory.Instance.creat("asset.water.PickIconLoop");
         _pickEffectLoop = new SimpleMovie(_loc6_,null,0);
         _pickEffectLoop.x = 187;
         _pickEffectLoop.y = 203;
         var _loc9_:MovieClip = ComponentFactory.Instance.creat("asset.water.PickProgressAsset");
         _pickProgress = new SimpleMovie(_loc9_,pickCallBack);
         _pickProgress.addEventListener("ONE_COMPLETE",__oneCompleteHandler);
         _pickProgress.x = 163;
         _pickProgress.y = 280;
         addChild(_pickEffect);
         addChild(_pickEffectAppear);
         addChild(_pickProgress);
         var _loc3_:MovieClip = ComponentFactory.Instance.creat("asset.water.PickProgressDisAppear");
         _progressDis = new SimpleMovie(_loc3_);
         _progressDis.x = 231;
         _progressDis.y = 242;
      }
      
      private function __oneCompleteHandler(param1:Event) : void
      {
         var _loc2_:MovieClip = ComponentFactory.Instance.creat("asset.core.AlertTxtEffect");
         _pickAlert = new SimpleMovie(_loc2_);
         _pickAlert.x = 150;
         _pickAlert.y = 200;
         if(_progressDis.movie)
         {
            _progressDis.movie.content.txt.text = _pickEffect.movie.content.txt.text;
         }
         _resultCount = _resultCount + 1;
         if(_resultCount == 2)
         {
            _pickAlert.movie["content"]["mc1"].txt.text = _pickResultArr[0].toString();
            _pickAlert.movie["content"]["mc1"].txt.setTextFormat(ComponentFactory.Instance.model.getSet("water.AlertStyle_t"));
         }
         if(_resultCount == 3)
         {
            _pickAlert.movie["content"]["mc1"].txt.text = _pickResultArr[1].toString();
            _pickAlert.movie["content"]["mc1"].txt.setTextFormat(ComponentFactory.Instance.model.getSet("water.AlertStyle_t"));
         }
         if(_resultCount == 4)
         {
            _pickAlert.movie["content"]["mc1"].txt.text = _pickResultArr[2].toString();
            _pickAlert.movie["content"]["mc1"].txt.setTextFormat(ComponentFactory.Instance.model.getSet("water.AlertStyle_t"));
         }
         addChild(_pickAlert);
      }
      
      private function pickCallBack() : void
      {
         if(_pickEffectLoop)
         {
            _pickEffectLoop.dispose();
         }
         if(_pickEffect)
         {
            _pickEffect.dispose();
         }
         var _loc2_:MovieClip = ComponentFactory.Instance.creat("asset.water.CircleDisAppear");
         _pickCircleDisAppear = new SimpleMovie(_loc2_);
         _pickCircleDisAppear.x = 137;
         _pickCircleDisAppear.y = 143;
         var _loc1_:MovieClip = ComponentFactory.Instance.creat("asset.water.PickIconDisAppear");
         _pickEffectDisAppear = new SimpleMovie(_loc1_,disCallBack);
         _pickEffectDisAppear.x = 187;
         _pickEffectDisAppear.y = 203;
         addChild(_pickCircleDisAppear);
         addChild(_pickEffectDisAppear);
         addChild(_progressDis);
         if(_pickProgress)
         {
            _pickProgress.removeEventListener("ONE_COMPLETE",__oneCompleteHandler);
         }
         _pickProgress = null;
         _pickEffect = null;
         _pickEffectAppear = null;
         _resultCount = 1;
      }
      
      private function disCallBack() : void
      {
         _pickEffectDisAppear = null;
         _pickCircleDisAppear = null;
         updateState();
         if(hitTestPoint(StageReferance.stage.mouseX,StageReferance.stage.mouseY))
         {
            dispatchEvent(new MouseEvent("mouseOver"));
         }
         this.mouseEnabled = true;
         this.mouseChildren = true;
      }
      
      private function __cleanEffectHandler(param1:NotificationEvent) : void
      {
         if(_waterEffect)
         {
            _waterEffect.dispose();
            _waterEffect = null;
         }
         if(_waterAlert)
         {
            _waterAlert.dispose();
            _waterAlert = null;
         }
         if(_pickEffect)
         {
            _pickEffect.dispose();
            _pickEffect = null;
         }
         if(_pickEffectAppear)
         {
            _pickEffectAppear.dispose();
            _pickEffectAppear = null;
         }
         if(_pickProgress)
         {
            _pickProgress.dispose();
            _pickProgress = null;
         }
         if(_pickAlert)
         {
            _pickAlert.dispose();
            _pickAlert = null;
         }
         if(_pickCircleDisAppear)
         {
            _pickCircleDisAppear.dispose();
            _pickCircleDisAppear = null;
         }
         if(_pickEffectDisAppear)
         {
            _pickEffectDisAppear.dispose();
            _pickEffectDisAppear = null;
         }
         CursorManagerII.instance.resetCursor();
         CursorManagerII.instance.show();
      }
      
      public function set waterFlag(param1:Boolean) : void
      {
         _waterMouseFlag = param1;
      }
      
      public function set pickFlag(param1:Boolean) : void
      {
         _pickMouoseFlag = param1;
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}

