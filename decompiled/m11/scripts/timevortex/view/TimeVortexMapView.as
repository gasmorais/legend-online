package timevortex.view
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.TimeVortexEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import managers.TimeVortexManager;
   import mvc.controler.TimeVortexController;
   import mvc.module.selectcampaign.CampaignAreaInfo;
   import mvc.module.selectcampaign.CampaignChapterInfo;
   import mvc.module.timevortex.TimeVortexModel;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.ArmyManager;
   import yishi.manager.CampaignRankManager;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   
   public class TimeVortexMapView extends Sprite implements Disposeable, IEnterFrame
   {
      
      private var _mapCover:DisplayObject;
      
      private var _map:Component;
      
      private var _crackView:TimeVortexCrackView;
      
      private var _pointViewArr:Vector.<TimeVortexPointView>;
      
      private var _pointArr:Vector.<Point>;
      
      private var _pointDataDic:SimpleDictionary;
      
      private var _pointViewDic:SimpleDictionary;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _mapIcon:MovieClip;
      
      private var _newEffect:MovieClip;
      
      private var _selfEffect:MovieClip;
      
      private var _crackEffect:MovieClip;
      
      private var _model:TimeVortexModel = TimeVortexManager.instance.model;
      
      private var _controller:TimeVortexController = FrameControllerManager.instance.timeVortexController;
      
      private var _playerInfo:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
      
      private var _openList:Array;
      
      private var _lastTime:Number = getTimer();
      
      private var _timeCount:int = 0;
      
      private var _countDiff:int = 1;
      
      private var _currentIndex:int = 0;
      
      private var _currentCrackId:int = 0;
      
      private var _currentSelected:TimeVortexPointView;
      
      private var _currentCrackOnPoint:TimeVortexPointView;
      
      public function TimeVortexMapView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _mapCover = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexMapView.frameCover");
         _map = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexMapView.mapWorldIcon");
         _newEffect = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexMapView.pointEffect");
         _selfEffect = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexMapView.pointEffect");
         _crackEffect = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexMapView.crackEffect");
         addChild(_map);
         addChild(_mapCover);
         _crackView = new TimeVortexCrackView(_crackEffect);
         _pointViewArr = new Vector.<TimeVortexPointView>();
         _pointArr = new Vector.<Point>();
         _pointDataDic = new SimpleDictionary(true);
         _pointViewDic = new SimpleDictionary(true);
         _buttonGroup = new SelectedButtonGroup();
         _openList = [];
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_mapCover);
         _mapCover = null;
         ObjectUtils.disposeObject(_crackView);
         _crackView = null;
         ObjectUtils.disposeObject(_buttonGroup);
         _buttonGroup = null;
         ObjectUtils.disposeObject(_openList);
         _openList = null;
         ObjectUtils.disposeViolentMc(_mapIcon);
         _mapIcon = null;
         ObjectUtils.disposeViolentMc(_newEffect);
         _newEffect = null;
         ObjectUtils.disposeViolentMc(_selfEffect);
         _selfEffect = null;
         ObjectUtils.disposeViolentMc(_crackEffect);
         _crackEffect = null;
         ObjectUtils.disposeObject(_currentCrackOnPoint);
         _currentCrackOnPoint = null;
         LogicUtils.disposeDisplayCollection(_pointViewArr);
         _pointViewArr = null;
         ObjectUtils.disposeObject(_map);
         _map = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _pointArr = null;
         _pointDataDic = null;
         _pointViewDic = null;
         _model = null;
         _controller = null;
         _playerInfo = null;
      }
      
      private function addEvent() : void
      {
         _model.addEventListener("SELECTED_CHAPTER_CHANGE",__selectedChapterChangeHandler);
         _buttonGroup.addEventListener("change",__itemSelectedHandler);
         EnterFrameManager.instance.registeEnterFrame(this);
      }
      
      private function removeEvent() : void
      {
         if(_model)
         {
            _model.removeEventListener("SELECTED_CHAPTER_CHANGE",__selectedChapterChangeHandler);
         }
         if(_buttonGroup)
         {
            _buttonGroup.removeEventListener("change",__itemSelectedHandler);
         }
         for each(var _loc1_:TimeVortexPointView in _pointViewArr)
         {
            _loc1_.removeEventListener("click",__itemSelectedHandler);
         }
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      public function enterFrame() : void
      {
         for each(var _loc2_:TimeVortexPointView in _pointViewArr)
         {
            if(_loc2_.parent && _loc2_.visible)
            {
               _loc2_.execute();
            }
         }
         var _loc1_:Number = getTimer();
         var _loc3_:Number = _loc1_ - _lastTime;
         var _loc4_:int = 0;
         if(_loc3_ >= 1000)
         {
            _countDiff = _loc3_ / 1000;
            _timeCount += _countDiff;
            _lastTime = _loc1_;
         }
         if(_timeCount >= 20)
         {
            _loc4_ = int(_openList[_currentIndex]);
            if(_loc4_ != _currentCrackId)
            {
               TimeVortexManager.instance.lookUpSingle(_loc4_);
            }
            TimeVortexManager.instance.lookUpCrack();
            _timeCount = 0;
            _currentIndex = _currentIndex + 1;
            if(_currentIndex >= _openList.length)
            {
               _currentIndex = 0;
            }
         }
      }
      
      private function __itemSelectedHandler(param1:Event) : void
      {
         param1 && SoundManager.instance.play("018");
         _currentSelected = _buttonGroup.getSelectedItem() as TimeVortexPointView;
         if(_currentSelected && _currentSelected.viewContent == null)
         {
            _currentSelected.addEventListener("VIEW_CONTENT_LOADED",__viewLoadedHandler);
         }
         else if(_currentSelected && _currentSelected.data)
         {
            _model.point = _currentSelected.point;
            _model.selectedArea = _currentSelected.data;
         }
         else
         {
            _model.selectedArea = null;
         }
      }
      
      private function __viewLoadedHandler(param1:TimeVortexEvent) : void
      {
         _currentSelected.removeEventListener("VIEW_CONTENT_LOADED",__viewLoadedHandler);
         if(_currentSelected && _currentSelected.data)
         {
            _model.point = _currentSelected.point;
            _model.selectedArea = _currentSelected.data;
         }
         else
         {
            _model.selectedArea = null;
         }
      }
      
      private function __selectedChapterChangeHandler(param1:TimeVortexEvent) : void
      {
         refreshPointData();
         refreshPointView();
         refreshCrackView();
         refreshMap();
         defaultSelect();
      }
      
      private function defaultSelect() : void
      {
         var _loc1_:CampaignAreaInfo = null;
         _buttonGroup.selectIndex = -1;
         if(_model.taskCampaignTem)
         {
            _loc1_ = _model.selectedChapter.getAreaByCampaignTem(_model.taskCampaignTem);
            _model.taskCampaignTem = null;
         }
         else
         {
            _loc1_ = _model.selectedChapter.getMaxSelectAewa();
         }
         if(_loc1_)
         {
            _buttonGroup.selectIndex = _buttonGroup.itemLength - _loc1_.areaId % 10;
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
         var _loc6_:CampaignAreaInfo = null;
         var _loc5_:Point = null;
         var _loc1_:CampaignTemplate = null;
         var _loc3_:int = 0;
         cleanPointData();
         _currentIndex = 0;
         _pointArr.splice(0,_pointArr.length);
         _openList.splice(0,_openList.length);
         var _loc4_:Array = _model.selectedChapter.areaDic.getList();
         _loc4_.sortOn("areaId",0x10 | 2);
         var _loc2_:int = int(_loc4_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc6_ = _loc4_[_loc3_] as CampaignAreaInfo;
            _loc5_ = new Point();
            _loc5_.x = _loc6_.posX;
            _loc5_.y = _loc6_.posY;
            _pointArr.push(_loc5_);
            _pointDataDic.add(_loc5_.x + "_" + _loc5_.y,_loc6_);
            _loc1_ = _loc6_.getMapById(_loc6_.campaignId);
            if(_loc1_ && (_loc1_.state == 2 || _loc1_.state == 1))
            {
               _openList.push(_loc6_.campaignId);
            }
            _loc3_++;
         }
      }
      
      private function cleanPointData() : void
      {
         _buttonGroup.removeAllItem();
         _pointDataDic.clear();
         _pointViewDic.clear();
         for each(var _loc1_:TimeVortexPointView in _pointViewArr)
         {
            _loc1_.data = null;
         }
      }
      
      private function refreshPointView() : void
      {
         var _loc2_:TimeVortexPointView = null;
         var _loc5_:Point = null;
         var _loc1_:CampaignAreaInfo = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(_pointArr.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _pointArr[_loc4_];
            if(_loc4_ < _pointViewArr.length)
            {
               _loc2_ = _pointViewArr[_loc4_] as TimeVortexPointView;
            }
            else
            {
               _loc2_ = new TimeVortexPointView(_newEffect,_selfEffect);
               _pointViewArr.push(_loc2_);
            }
            _loc1_ = _pointDataDic[_loc5_.x + "_" + _loc5_.y] as CampaignAreaInfo;
            _loc2_.x = _loc5_.x;
            _loc2_.y = _loc5_.y;
            _buttonGroup.addSelectItem(_loc2_);
            _loc2_.data = _loc1_;
            _pointViewDic.add(_loc1_.campaignId,_loc2_);
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
         var _loc1_:String = PathManager.resourcePath + "swf/singlecampaign1/" + _model.selectedChapter.chapterId + "/map/" + _model.selectedChapter.chapterId + ".swf";
         LoaderManagerII.instance.load(_loc1_,2,8,__onComplete);
      }
      
      private function refreshLine() : void
      {
         var _loc2_:int = 0;
         var _loc1_:CampaignTemplate = null;
         if(_mapIcon)
         {
            _loc2_ = 0;
            for each(var _loc3_:CampaignAreaInfo in _model.selectedChapter.areaDic)
            {
               _loc1_ = _loc3_.getMapByDifficult(1);
               if(_loc1_ && _loc1_.state != 0)
               {
                  _loc2_ = _loc2_ > _loc1_.AreaId ? _loc2_ : int(_loc1_.AreaId);
               }
            }
            if(_loc2_ == 0)
            {
               _loc2_ = int(_model.selectedChapter.chapterId + "01");
            }
            _mapIcon.gotoAndStop(1);
         }
      }
      
      public function refreshCrackView() : void
      {
         var _loc5_:Point = null;
         _currentCrackId = 0;
         var _loc4_:int = -1;
         if(_crackView && _crackView.parent)
         {
            _loc4_ = _crackView.parent.getChildIndex(_crackView);
            _crackView.parent.removeChild(_crackView);
         }
         if(_currentCrackOnPoint && !_currentCrackOnPoint.parent)
         {
            if(_loc4_ == -1)
            {
               _map.addChild(_currentCrackOnPoint);
            }
            else
            {
               _map.addChildAt(_currentCrackOnPoint,_loc4_);
            }
         }
         if(_currentCrackOnPoint)
         {
            _currentCrackOnPoint.removeEventListener("VIEW_CONTENT_LOADED",__pointViewLoadedHandler);
         }
         var _loc2_:CampaignChapterInfo = _model.selectedLand.chapterCrackDic[_model.selectedChapter.chapterId];
         if(!_loc2_)
         {
            return;
         }
         if(!_loc2_.areaDic)
         {
            return;
         }
         var _loc3_:Array = _loc2_.areaDic.getList();
         if(!_loc3_)
         {
            return;
         }
         if(_loc3_.length < 1)
         {
            return;
         }
         var _loc1_:CampaignAreaInfo = _loc3_[0] as CampaignAreaInfo;
         if(!_loc1_)
         {
            return;
         }
         _crackView.data = _loc1_;
         _currentCrackId = _loc1_.campaignId;
         _currentCrackOnPoint = _pointViewDic[_loc1_.campaignId];
         if(_currentCrackOnPoint && _currentCrackOnPoint.viewContent == null)
         {
            _currentCrackOnPoint.addEventListener("VIEW_CONTENT_LOADED",__pointViewLoadedHandler);
         }
         else if(_currentCrackOnPoint && _currentCrackOnPoint.data && bossChallenged)
         {
            _loc5_ = _currentCrackOnPoint.localToGlobal(_currentCrackOnPoint.referencePoint);
            _loc5_ = globalToLocal(_loc5_);
            _crackView.x = _loc5_.x;
            _crackView.y = _loc5_.y;
            if(_currentCrackOnPoint && _currentCrackOnPoint.parent)
            {
               _loc4_ = _currentCrackOnPoint.parent.getChildIndex(_currentCrackOnPoint);
               _currentCrackOnPoint.parent.removeChild(_currentCrackOnPoint);
            }
            if(_loc4_ == -1)
            {
               _map.addChild(_crackView);
            }
            else
            {
               _map.addChildAt(_crackView,_loc4_);
            }
         }
      }
      
      private function __pointViewLoadedHandler(param1:TimeVortexEvent) : void
      {
         var _loc3_:Point = null;
         _currentCrackOnPoint.removeEventListener("VIEW_CONTENT_LOADED",__pointViewLoadedHandler);
         var _loc2_:int = -1;
         if(_currentCrackOnPoint && _currentCrackOnPoint.data && bossChallenged)
         {
            _loc3_ = _currentCrackOnPoint.localToGlobal(_currentCrackOnPoint.referencePoint);
            _loc3_ = globalToLocal(_loc3_);
            _crackView.x = _loc3_.x;
            _crackView.y = _loc3_.y;
            if(_currentCrackOnPoint && _currentCrackOnPoint.parent)
            {
               _loc2_ = _currentCrackOnPoint.parent.getChildIndex(_currentCrackOnPoint);
               _currentCrackOnPoint.parent.removeChild(_currentCrackOnPoint);
            }
            if(_loc2_ == -1)
            {
               _map.addChild(_crackView);
            }
            else
            {
               _map.addChildAt(_crackView,_loc2_);
            }
         }
      }
      
      private function get bossChallenged() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:Dictionary = CampaignRankManager.instance.timeVortexRankDic;
         if(_loc2_[_currentCrackId])
         {
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onComplete);
         removeEvent();
         uninitView();
      }
   }
}

