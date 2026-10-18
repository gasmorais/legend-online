package selectcampaign.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.SelectCampaignEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.controler.SelectCampaignController;
   import mvc.module.selectcampaign.CampaignAreaInfo;
   import mvc.module.selectcampaign.SelectCampaignModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.utils.SimpleDictionary;
   
   public class SelectCpMapView extends Sprite implements Disposeable
   {
      
      private var _map:Component;
      
      private var _mapShape:Bitmap;
      
      private var _pointViewArr:Vector.<CampaignPointView>;
      
      private var _pointArr:Vector.<Point>;
      
      private var _pointDataDic:SimpleDictionary;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _mapIcon:MovieClip;
      
      private var _effect:MovieClip;
      
      private var _tipsContainer:Sprite;
      
      private var _currentSelected:CampaignPointView;
      
      public function SelectCpMapView()
      {
         super();
         init();
         initEvent();
      }
      
      private function init() : void
      {
         _map = ComponentFactory.Instance.creatComponentByStylename("selectCP.MapWorldIcon");
         _mapShape = ComponentFactory.Instance.creatBitmap("asset.selectCP.MapShape");
         addChild(_map);
         _map.addChild(_mapShape);
         _mapShape.width = 930;
         _effect = ComponentFactory.Instance.creatCustomObject("selectCP.PointEffect");
         _tipsContainer = new Sprite();
         addChild(_tipsContainer);
         _pointViewArr = new Vector.<CampaignPointView>();
         _pointArr = new Vector.<Point>();
         _pointDataDic = new SimpleDictionary(true);
         _buttonGroup = new SelectedButtonGroup();
      }
      
      private function initEvent() : void
      {
         model.addEventListener("SELECTED_CHAPTER_CHANGE",__selectedChapterChangeHandler);
         _buttonGroup.addEventListener("change",__itemSelectedHandler);
      }
      
      private function removeEvent() : void
      {
         model.removeEventListener("SELECTED_CHAPTER_CHANGE",__selectedChapterChangeHandler);
         if(_buttonGroup)
         {
            _buttonGroup.removeEventListener("change",__itemSelectedHandler);
         }
         for each(var _loc1_:CampaignPointView in _pointViewArr)
         {
            _loc1_.removeEventListener("click",__itemSelectedHandler);
         }
      }
      
      private function __itemSelectedHandler(param1:Event) : void
      {
         param1 && SoundManager.instance.play("018");
         _currentSelected = _buttonGroup.getSelectedItem() as CampaignPointView;
         if(_currentSelected && _currentSelected.viewContent == null)
         {
            _currentSelected.addEventListener("VIEW_CONTENT_LOADED",__viewLoadedHandler);
         }
         else if(_currentSelected && _currentSelected.data)
         {
            model.point = _currentSelected.point;
            model.selectedArea = _currentSelected.data;
         }
         else
         {
            model.selectedArea = null;
         }
      }
      
      private function __viewLoadedHandler(param1:SelectCampaignEvent) : void
      {
         _currentSelected.removeEventListener("VIEW_CONTENT_LOADED",__viewLoadedHandler);
         if(_currentSelected && _currentSelected.data)
         {
            model.point = _currentSelected.point;
            model.selectedArea = _currentSelected.data;
         }
         else
         {
            model.selectedArea = null;
         }
      }
      
      private function __selectedChapterChangeHandler(param1:SelectCampaignEvent) : void
      {
         refreshPointData();
         refreshPointView();
         refreshMap();
         defaultSelect();
      }
      
      private function defaultSelect() : void
      {
         var _loc1_:CampaignAreaInfo = null;
         _buttonGroup.selectIndex = -1;
         if(model.taskCampaignTem)
         {
            _loc1_ = model.selectedChapter.getAreaByCampaignTem(model.taskCampaignTem);
         }
         else
         {
            _loc1_ = model.selectedChapter.getMaxSelectAewa();
         }
         if(_loc1_)
         {
            _buttonGroup.selectIndex = _loc1_.areaId % 10 - 1;
         }
         else
         {
            __itemSelectedHandler(null);
         }
      }
      
      private function __onComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(!_pointViewArr)
         {
            return;
         }
         ObjectUtils.disposeViolentMc(_mapIcon);
         _mapIcon = null;
         if(param2)
         {
            _mapIcon = param2 as MovieClip;
            _mapIcon.width = 930;
            _map.addChildAt(_mapIcon,0);
         }
         refreshLine();
      }
      
      private function refreshPointData() : void
      {
         var _loc2_:int = 0;
         var _loc5_:CampaignAreaInfo = null;
         var _loc4_:Point = null;
         cleanPointData();
         _pointArr.splice(0,_pointArr.length);
         var _loc3_:Array = model.selectedChapter.areaDic.getList();
         _loc3_.sortOn("areaId");
         var _loc1_:int = int(_loc3_.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc5_ = _loc3_[_loc2_] as CampaignAreaInfo;
            _loc4_ = new Point();
            _loc4_.x = _loc5_.posX;
            _loc4_.y = _loc5_.posY;
            _pointArr.push(_loc4_);
            _pointDataDic.add(_loc4_.x + "_" + _loc4_.y,_loc5_);
            _loc2_++;
         }
      }
      
      private function cleanPointData() : void
      {
         _buttonGroup.removeAllItem();
         _pointDataDic.clear();
         for each(var _loc1_:CampaignPointView in _pointViewArr)
         {
            _loc1_.data = null;
         }
      }
      
      private function refreshPointView() : void
      {
         var _loc2_:CampaignPointView = null;
         var _loc5_:Point = null;
         var _loc1_:CampaignAreaInfo = null;
         var _loc4_:int = 0;
         var _loc6_:StripView = null;
         var _loc3_:int = int(_pointArr.length);
         ObjectUtils.disposeAllChildren(_tipsContainer);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _pointArr[_loc4_];
            if(_loc4_ < _pointViewArr.length)
            {
               _loc2_ = _pointViewArr[_loc4_] as CampaignPointView;
            }
            else
            {
               _loc2_ = new CampaignPointView(_effect);
               _pointViewArr.push(_loc2_);
            }
            _loc1_ = _pointDataDic[_loc5_.x + "_" + _loc5_.y] as CampaignAreaInfo;
            _loc2_.x = _loc5_.x;
            _loc2_.y = _loc5_.y;
            if(_loc1_.getMapByDifficult(1).MinLevel <= thane.grades)
            {
               _buttonGroup.addSelectItem(_loc2_);
            }
            _loc2_.data = _loc1_;
            _loc6_ = ComponentFactory.Instance.creatCustomObject("selectCP.TaskTip");
            _loc6_.x = _loc2_.x;
            _loc6_.y = _loc2_.y;
            _loc6_.addChild(createShape());
            _loc6_.tipData = LanguageMgr.GetTranslation("selectcampaign.view.SelectCpMapView.TaskTipsText");
            _loc6_.visible = false;
            _tipsContainer.addChild(_loc6_);
            _loc2_.setTips(_loc6_);
            _map.addChild(_loc2_);
            _loc4_++;
         }
      }
      
      private function createShape(param1:int = 36) : Shape
      {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(16711680,0);
         _loc2_.graphics.drawRect(0,0,param1,param1);
         _loc2_.graphics.endFill();
         return _loc2_;
      }
      
      private function refreshMap() : void
      {
         ObjectUtils.disposeViolentMc(_mapIcon);
         _mapIcon = null;
         var _loc1_:String = PathManager.resourcePath + "swf/singlecampaign1/" + model.selectedChapter.chapterId + "/map/" + model.selectedChapter.chapterId + ".swf";
         LoaderManagerII.instance.load(_loc1_,2,8,__onComplete);
      }
      
      private function refreshLine() : void
      {
         var _loc2_:int = 0;
         var _loc1_:CampaignTemplate = null;
         if(_mapIcon)
         {
            _loc2_ = 0;
            for each(var _loc3_:CampaignAreaInfo in model.selectedChapter.areaDic)
            {
               _loc1_ = _loc3_.getMapByDifficult(1);
               if(_loc1_ && _loc1_.state != 0)
               {
                  _loc2_ = _loc2_ > _loc1_.AreaId ? _loc2_ : int(_loc1_.AreaId);
               }
            }
            if(_loc2_ == 0)
            {
               _loc2_ = int(model.selectedChapter.chapterId + "01");
            }
            _mapIcon.gotoAndStop(1);
         }
      }
      
      public function get pointViewArr() : Vector.<CampaignPointView>
      {
         return _pointViewArr;
      }
      
      private function get model() : SelectCampaignModel
      {
         return control.model;
      }
      
      private function get control() : SelectCampaignController
      {
         return FrameControllerManager.instance.selectCampaignControler;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         var _loc1_:CampaignPointView = null;
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onComplete);
         removeEvent();
         ObjectUtils.disposeViolentMc(_map);
         _map = null;
         while(_pointViewArr && _pointViewArr.length > 0)
         {
            _loc1_ = _pointViewArr.pop();
            _loc1_.dispose();
            _loc1_ = null;
         }
         _pointViewArr = null;
         if(_currentSelected)
         {
            _currentSelected.dispose();
         }
         _currentSelected = null;
         if(_pointDataDic)
         {
            _pointDataDic.clear();
         }
         _pointDataDic = null;
         _pointArr = null;
         ObjectUtils.disposeViolentMc(_mapIcon);
         _mapIcon = null;
         ObjectUtils.disposeObject(_mapShape);
         _mapShape = null;
         if(_buttonGroup)
         {
            _buttonGroup.dispose();
         }
         _buttonGroup = null;
         ObjectUtils.disposeViolentMc(_effect);
         _effect = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

