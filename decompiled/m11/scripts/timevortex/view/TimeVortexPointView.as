package timevortex.view
{
   import avatar.view.ShowAvatar;
   import com.pickgliss.effect.AdjustColor;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import events.TimeVortexEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import managers.TimeVortexManager;
   import mvc.controler.TimeVortexController;
   import mvc.module.selectcampaign.CampaignAreaInfo;
   import mvc.module.timevortex.TimeVortexModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class TimeVortexPointView extends Sprite implements Disposeable, ISelectable
   {
      
      private static const HIT_AREA_CACHE:Dictionary = new Dictionary();
      
      private var _viewPoint:Component;
      
      private var _viewContent:MovieClip;
      
      private var _bossAvatar:TimeVortexShowAvatar;
      
      private var _lairdAvatar:ShowAvatar;
      
      private var _defaultAvatar:Image;
      
      private var _lairdNameTxt:FilterFrameText;
      
      private var _nameTxt:GradientText;
      
      private var _newEffect:MovieClip;
      
      private var _selfEffect:MovieClip;
      
      private var _selected:Boolean;
      
      private var _isNew:Boolean;
      
      private var _isSelf:Boolean;
      
      private var _state:String;
      
      private var _scaleBack:MovieClip;
      
      private var _adjustColorFilter:ColorMatrixFilter;
      
      private var _glowFilter:GlowFilter;
      
      private var _data:CampaignAreaInfo;
      
      private var _uuid:String;
      
      private var _model:TimeVortexModel = TimeVortexManager.instance.model;
      
      private var _controller:TimeVortexController = FrameControllerManager.instance.timeVortexController;
      
      private var _playerInfo:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
      
      private var _areaNameTxt:FilterFrameText;
      
      private var _recommendGrades:FilterFrameText;
      
      private var _curUrl:String;
      
      private var _hitArea:Sprite;
      
      private var _hitBitmap:Bitmap;
      
      private var _bossNameStr:String = "";
      
      private var _preCampaignId:int = 0;
      
      public function TimeVortexPointView(param1:MovieClip, param2:MovieClip)
      {
         super();
         _newEffect = param1;
         _selfEffect = param2;
         initView();
         initEvent();
         mouseChildren = false;
      }
      
      private function initView() : void
      {
         _viewPoint = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexPointView.mapPoint");
         _scaleBack = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexPointView.scaleBack");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexPointView.nameTxt");
         _bossAvatar = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexPointView.bossAvatar");
         _lairdAvatar = ComponentFactory.Instance.creatCustomObject("timevortex.TimeVortexPointView.lairdAvatar");
         _defaultAvatar = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexPointView.defaultAvatar");
         _lairdNameTxt = ComponentFactory.Instance.creatComponentByStylename("timevortex.TimeVortexPointView.lairdNameTxt");
         _areaNameTxt = ComponentFactory.Instance.creatComponentByStylename("room.InstaneRight.recommendGrades");
         _recommendGrades = ComponentFactory.Instance.creatComponentByStylename("room.InstaneRight.recommendGrades");
         _defaultAvatar.setFrame(4);
         addChild(_viewPoint);
         var _loc1_:AdjustColor = new AdjustColor();
         _loc1_.brightness = 17;
         _loc1_.contrast = 8;
         _loc1_.hue = 0;
         _loc1_.saturation = 0;
         _adjustColorFilter = new ColorMatrixFilter(_loc1_.CalculateFinalFlatArray());
         _glowFilter = new GlowFilter(16639897,1,10,10,1.3);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bossAvatar);
         _bossAvatar = null;
         ObjectUtils.disposeObject(_lairdAvatar);
         _lairdAvatar = null;
         ObjectUtils.disposeObject(_defaultAvatar);
         _defaultAvatar = null;
         ObjectUtils.disposeObject(_lairdNameTxt);
         _lairdNameTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_scaleBack);
         _scaleBack = null;
         ObjectUtils.disposeObject(_adjustColorFilter);
         _adjustColorFilter = null;
         ObjectUtils.disposeObject(_glowFilter);
         _glowFilter = null;
         ObjectUtils.disposeObject(_hitArea);
         _hitArea = null;
         ObjectUtils.disposeViolentMc(_viewPoint);
         _viewPoint = null;
         ObjectUtils.disposeViolentMc(_viewContent);
         _viewContent = null;
         ObjectUtils.disposeViolentMc(_newEffect);
         _newEffect = null;
         ObjectUtils.disposeViolentMc(_selfEffect);
         _selfEffect = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
         _adjustColorFilter = null;
         _glowFilter = null;
         _model = null;
         _controller = null;
         _playerInfo = null;
         _data = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__mouseOverHandler);
         addEventListener("mouseOut",__mouseOutHandler);
         addEventListener("click",__mouseClickHandler);
         _model.addEventListener("SINGLE_LAIRD_INFO_CHANGE",__singleLairdInfoChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__mouseOverHandler);
         removeEventListener("mouseOut",__mouseOutHandler);
         removeEventListener("click",__mouseClickHandler);
         if(_model)
         {
            _model.removeEventListener("SINGLE_LAIRD_INFO_CHANGE",__singleLairdInfoChangeHandler);
         }
      }
      
      private function __singleLairdInfoChangeHandler(param1:TimeVortexEvent) : void
      {
         var _loc2_:CampaignAreaInfo = param1.data as CampaignAreaInfo;
         if(!_data || !_loc2_)
         {
            return;
         }
         if(_data.campaignId != _loc2_.campaignId)
         {
            return;
         }
         if(_uuid == _loc2_.uuid)
         {
            return;
         }
         refreshView();
         _uuid = _loc2_.uuid;
      }
      
      public function get viewContent() : MovieClip
      {
         return _viewContent;
      }
      
      public function get point() : Point
      {
         var _loc1_:Point = new Point();
         if(_viewContent)
         {
            _loc1_ = new Point(_viewContent["namepos"].x,_viewContent["namepos"].y);
         }
         return _loc1_;
      }
      
      public function get referencePoint() : Point
      {
         var _loc1_:Point = new Point();
         if(_viewContent)
         {
            _loc1_ = new Point(_viewContent["referencePoint"].x,_viewContent["namepos"].y);
         }
         return _loc1_;
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         _model.point = point;
         _model.selectedArea = _data;
         _model.dispatchEvent(new TimeVortexEvent("SELECTED_AREA_CHANGE",point));
         _controller.openChallengeFrame();
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         if(isNew || isSelf || _state == "default")
         {
            return;
         }
         if(_viewContent)
         {
            _viewContent["build_icon"].filters = [_adjustColorFilter,_glowFilter];
         }
         updateAvatarFilters([_adjustColorFilter,_glowFilter]);
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(isNew || isSelf || _state == "default")
         {
            return;
         }
         if(_viewContent)
         {
            _viewContent["build_icon"].filters = null;
         }
         updateAvatarFilters();
      }
      
      private function refreshView() : void
      {
         _newEffect.gotoAndStop(1);
         _selfEffect.gotoAndStop(1);
         if(!_data)
         {
            visible = false;
            clearViewContent();
            return;
         }
         visible = true;
         mouseEnabled = true;
         buttonMode = true;
         var _loc1_:CampaignTemplate = _data.getMapByDifficult(2);
         if(!_loc1_ || _loc1_.state != 0)
         {
            _loc1_ = _data.getMapByDifficult(1);
         }
         if(_loc1_)
         {
            _areaNameTxt.x = 15;
            _areaNameTxt.text = _loc1_.CampaignName;
            _areaNameTxt.width = _areaNameTxt.textWidth + 10;
            if(_loc1_.state == 0)
            {
               mouseEnabled = false;
               buttonMode = false;
               _state = "disable";
            }
            else if(_loc1_.state == 1)
            {
               _state = "over";
               mouseEnabled = true;
            }
            else
            {
               _state = "open";
               mouseEnabled = true;
            }
            if(_loc1_.PreCampaignId == _playerInfo.timeVortexNode)
            {
               isNew = true;
               isSelf = false;
            }
            else if(_loc1_.CampaignId == _playerInfo.timeVortexCapture)
            {
               isNew = false;
               isSelf = true;
            }
            else
            {
               isNew = false;
               isSelf = false;
            }
            updateEffectState();
            startLoad();
         }
      }
      
      private function startLoad() : void
      {
         clearViewContent();
         var _loc1_:String = PathManager.resourcePath + "swf/singlecampaign1/" + _model.selectedChapter.chapterId + "/" + _data.areaId + ".swf";
         _curUrl = _loc1_;
         LoaderManagerII.instance.load(_loc1_,2,8,__onComplete);
      }
      
      private function __onComplete(param1:LoaderInfo, param2:Object) : void
      {
         if(_curUrl != param1.url)
         {
            return;
         }
         if(!_data)
         {
            return;
         }
         clearViewContent();
         if(param2)
         {
            _viewContent = param2 as MovieClip;
            updateHitArea();
            updateState();
         }
         if(_state != "default" && _state != "disable")
         {
            selected = _selected;
            isNew = _isNew;
            isSelf = _isSelf;
            updateEffectState();
         }
         _data.viewContentLoaded = true;
         dispatchEvent(new TimeVortexEvent("VIEW_CONTENT_LOADED"));
      }
      
      private function updateHitArea() : void
      {
         var _loc7_:BitmapData = null;
         var _loc5_:Rectangle = null;
         var _loc6_:Matrix = null;
         var _loc1_:Object = null;
         var _loc4_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:DisplayObject = _viewContent["build_icon"];
         if(_loc3_)
         {
            if(HIT_AREA_CACHE[_data.campaignId])
            {
               _loc1_ = HIT_AREA_CACHE[_data.campaignId];
               _hitArea = _loc1_["hitArea"];
               _loc4_ = Number(_loc1_["posX"]);
               _loc2_ = Number(_loc1_["posY"]);
               _loc7_ = _loc1_["bitData"];
            }
            else
            {
               _loc5_ = _loc3_.getBounds(_loc3_);
               _loc6_ = new Matrix();
               _loc7_ = new BitmapData(_loc5_.width + 10,_loc5_.height,true,0);
               _loc6_.translate(-_loc5_.x,-_loc5_.y);
               _loc7_.draw(_loc3_,_loc6_);
               _hitArea = DisplayUtils.getHitArea(_loc7_,5);
               _loc4_ = _loc3_.x + _loc5_.x;
               _loc2_ = _loc3_.y + _loc5_.y;
               _loc1_ = {};
               _loc1_["hitArea"] = _hitArea;
               _loc1_["posX"] = _loc4_;
               _loc1_["posY"] = _loc2_;
               _loc1_["bitData"] = _loc7_;
               HIT_AREA_CACHE[_data.campaignId] = _loc1_;
            }
            _hitArea.x = _loc4_;
            _hitArea.y = _loc2_;
            hitArea = _hitArea;
            addChild(_hitArea);
         }
      }
      
      private function updateState() : void
      {
         _viewContent.gotoAndStop(_state);
         var _loc2_:Boolean = false;
         var _loc1_:Boolean = false;
         if(_state == "open")
         {
            _viewContent.gotoAndStop("over");
            ObjectUtils.removeChildAllChildrenFromStage(_viewContent["backContain"]);
            ObjectUtils.removeChildAllChildrenFromStage(_viewContent["iconContain"]);
            _viewContent["backContain"].addChildAt(_scaleBack,0);
            updateInfoView();
            _loc2_ = true;
         }
         else if(_state == "over")
         {
            ObjectUtils.removeChildAllChildrenFromStage(_viewContent["backContain"]);
            ObjectUtils.removeChildAllChildrenFromStage(_viewContent["iconContain"]);
            _viewContent["backContain"].addChildAt(_scaleBack,0);
            updateInfoView();
            _loc1_ = true;
         }
         else if(_state == "default")
         {
            ObjectUtils.removeChildAllChildrenFromStage(_viewContent["backContain"]);
            ObjectUtils.removeChildAllChildrenFromStage(_viewContent["iconContain"]);
            _viewContent["backContain"].addChildAt(_scaleBack,0);
            updateInfoView();
         }
         else
         {
            ObjectUtils.removeChildAllChildrenFromStage(_viewContent["backContain"]);
            ObjectUtils.removeChildAllChildrenFromStage(_viewContent["iconContain"]);
         }
         if(_loc2_)
         {
            _lairdNameTxt.visible = false;
            _bossAvatar.data = data;
            _bossAvatar.showName(getBossName(_data.campaignId));
            _viewContent["backContain"].addChildAt(_lairdNameTxt,0);
            _viewContent["backContain"].addChildAt(_bossAvatar,0);
            _viewContent["backContain"].addChild(_areaNameTxt);
            _viewContent["backContain"].addChild(_recommendGrades);
         }
         else if(_loc1_)
         {
            if(_data.userId == 0)
            {
               _lairdNameTxt.visible = false;
               _viewContent["backContain"].addChildAt(_lairdNameTxt,0);
               _viewContent["backContain"].addChildAt(_defaultAvatar,0);
               _viewContent["backContain"].addChild(_areaNameTxt);
               _viewContent["backContain"].addChild(_recommendGrades);
            }
            else
            {
               _lairdNameTxt.text = _data.nickName;
               _lairdNameTxt.visible = true;
               _lairdAvatar.data = _data.thane;
               _viewContent["backContain"].addChildAt(_lairdNameTxt,0);
               _viewContent["backContain"].addChildAt(_lairdAvatar,0);
               _viewContent["backContain"].addChild(_areaNameTxt);
               _viewContent["backContain"].addChild(_recommendGrades);
            }
         }
         _viewPoint.addChild(_viewContent);
      }
      
      private function getBossName(param1:int) : String
      {
         var _loc2_:CampaignTemplate = null;
         var _loc4_:Array = null;
         var _loc3_:int = 0;
         var _loc5_:GameHeroTempInfo = null;
         if(_preCampaignId != param1)
         {
            _loc2_ = _data.getMapById(param1);
            if(_loc2_ && _loc2_.MapIds)
            {
               _loc4_ = _loc2_.MapIds.split(",");
               _loc3_ = int(_loc4_[0]);
               _loc5_ = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc3_);
               if(_loc5_)
               {
                  _bossNameStr = _loc5_.TemplateName;
               }
            }
         }
         return _bossNameStr;
      }
      
      private function updateInfoView() : void
      {
         if(_viewContent["referencePoint"])
         {
            _scaleBack.width = _areaNameTxt.width + 30;
            _viewContent["iconContain"].x = _viewContent["backContain"].x = _viewContent["build_icon"].x + (_viewContent["build_icon"].width - _viewContent["backContain"].width) / 2;
            _viewContent["iconContain"].y = _viewContent["backContain"].y - 10;
            _areaNameTxt.y = _scaleBack.y + 7;
         }
         else
         {
            _viewContent["iconContain"].x = _viewContent["backContain"].x;
            _viewContent["iconContain"].y = _viewContent["backContain"].y;
            _scaleBack.width = _areaNameTxt.width + 30;
            _scaleBack.x = -60;
            _areaNameTxt.y = _scaleBack.y + 7;
         }
      }
      
      public function set data(param1:CampaignAreaInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      public function get data() : CampaignAreaInfo
      {
         return _data;
      }
      
      public function execute() : void
      {
         if(_bossAvatar && _bossAvatar.parent && _bossAvatar.visible)
         {
            _bossAvatar.execute();
         }
      }
      
      public function clearViewContent() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onComplete);
         if(_scaleBack && _scaleBack.parent)
         {
            _scaleBack.parent.removeChild(_scaleBack);
         }
         if(_newEffect && _newEffect.parent && contains(_newEffect))
         {
            _newEffect.parent.removeChild(_newEffect);
         }
         if(_selfEffect && _selfEffect.parent && contains(_selfEffect))
         {
            _selfEffect.parent.removeChild(_selfEffect);
         }
         if(_nameTxt && _nameTxt.parent)
         {
            _nameTxt.parent.removeChild(_nameTxt);
         }
         if(_bossAvatar && _bossAvatar.parent)
         {
            _bossAvatar.parent.removeChild(_bossAvatar);
         }
         if(_lairdAvatar && _lairdAvatar.parent)
         {
            _lairdAvatar.parent.removeChild(_lairdAvatar);
         }
         if(_defaultAvatar && _defaultAvatar.parent)
         {
            _defaultAvatar.parent.removeChild(_defaultAvatar);
         }
         if(_lairdNameTxt && _lairdNameTxt.parent)
         {
            _lairdNameTxt.parent.removeChild(_lairdNameTxt);
         }
         if(_viewContent && _viewContent["build_icon"])
         {
            _viewContent["build_icon"].filters = null;
         }
         if(_viewContent && _viewContent.parent)
         {
            _viewContent.parent.removeChild(_viewContent);
         }
         if(_hitArea && _hitArea.parent)
         {
            _hitArea.parent.removeChild(_hitArea);
         }
         ObjectUtils.disposeViolentMc(_viewContent);
         if(_viewContent)
         {
            _viewContent = null;
         }
         if(_bossAvatar)
         {
            _bossAvatar.data = null;
         }
         if(_lairdAvatar)
         {
            _lairdAvatar.data = null;
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
      }
      
      public function get isNew() : Boolean
      {
         return _isNew;
      }
      
      public function set isNew(param1:Boolean) : void
      {
         _isNew = param1;
      }
      
      public function get isSelf() : Boolean
      {
         return _isSelf;
      }
      
      public function set isSelf(param1:Boolean) : void
      {
         _isSelf = param1;
      }
      
      private function updateEffectState() : void
      {
         var _loc1_:Point = null;
         var _loc2_:Boolean = false;
         var _loc3_:MovieClip = null;
         if(!_viewContent)
         {
            return;
         }
         if(isNew)
         {
            _loc2_ = true;
            _loc3_ = _newEffect;
         }
         else if(isSelf)
         {
            _loc2_ = true;
            _loc3_ = _selfEffect;
         }
         if(!_loc3_)
         {
            return;
         }
         if(_loc2_)
         {
            if(!contains(_loc3_))
            {
               _loc1_ = _viewContent.localToGlobal(new Point(_viewContent["circle"].x,_viewContent["circle"].y));
               _loc1_ = globalToLocal(_loc1_);
               if(isSpecialArea())
               {
                  _loc3_.x = _loc1_.x + 92;
                  _loc3_.y = _loc1_.y + 124;
               }
               else
               {
                  _loc3_.x = _loc1_.x - 28;
                  _loc3_.y = _loc1_.y - 15;
               }
               addChild(_loc3_);
               _loc3_.gotoAndPlay(1);
               _viewContent["build_icon"].filters = [_adjustColorFilter,_glowFilter];
               _viewContent.gotoAndStop(_state);
               updateAvatarFilters([_adjustColorFilter,_glowFilter]);
            }
         }
         else
         {
            _viewContent["build_icon"].filters = null;
            _viewContent.gotoAndStop(_state);
            updateAvatarFilters();
         }
      }
      
      private function updateAvatarFilters(param1:Array = null) : void
      {
         if(_bossAvatar && _bossAvatar.parent && _bossAvatar.visible)
         {
            _bossAvatar.filters = param1;
         }
         if(_lairdAvatar && _lairdAvatar.parent && _lairdAvatar.visible)
         {
            _lairdAvatar.filters = param1;
         }
         if(_defaultAvatar && _defaultAvatar.parent && _defaultAvatar.visible)
         {
            _defaultAvatar.filters = param1;
         }
      }
      
      private function isSpecialArea() : Boolean
      {
         if(data.areaId == 10701 || data.areaId == 10702)
         {
            return true;
         }
         return false;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return null;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearViewContent();
         uninitView();
      }
   }
}

