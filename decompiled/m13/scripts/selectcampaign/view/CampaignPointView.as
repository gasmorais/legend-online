package selectcampaign.view
{
   import com.pickgliss.effect.AdjustColor;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DoubleClickManager;
   import com.pickgliss.utils.ObjectUtils;
   import events.SelectCampaignEvent;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import mvc.module.selectcampaign.CampaignAreaInfo;
   import mvc.module.selectcampaign.SelectCampaignModel;
   import mvc.module.task.TaskCondictionTemplate;
   import mvc.module.task.TaskTemplate;
   import net.SingWarSocketSendManager;
   import yishi.datas.playerinfo.RankInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.CampaignRankManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TaskManage;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   
   public class CampaignPointView extends Sprite implements Disposeable, ISelectable
   {
      
      private var _viewPoint:Component;
      
      private var _viewContent:MovieClip;
      
      private var _effect:MovieClip;
      
      private var _selected:Boolean;
      
      private var _data:CampaignAreaInfo;
      
      private var _state:String;
      
      private var _hasTask:Boolean;
      
      private var _newIcon:Bitmap;
      
      private var _taskIconMc:MovieClip;
      
      private var _circle:Bitmap;
      
      private var _profile:ScaleFrameImage;
      
      private var _scaleBack:MovieClip;
      
      private var _adjustColorFilter:ColorMatrixFilter;
      
      private var _glowFilter:GlowFilter;
      
      private var _tipsObject:Sprite;
      
      private var _areaNameTxt:FilterFrameText;
      
      private var _recommendGrades:FilterFrameText;
      
      private var _curUrl:String;
      
      public function CampaignPointView(param1:MovieClip)
      {
         super();
         _effect = param1;
         init();
         initEvent();
         mouseChildren = false;
      }
      
      private function get model() : SelectCampaignModel
      {
         return FrameControllerManager.instance.selectCampaignControler.model;
      }
      
      private function init() : void
      {
         _viewPoint = ComponentFactory.Instance.creatComponentByStylename("selectCP.MapPoint");
         _newIcon = ComponentFactory.Instance.creatBitmap("asset.selectCP.NewIcon");
         _taskIconMc = ComponentFactory.Instance.creatCustomObject("selectCP.TaskIconMc");
         _circle = ComponentFactory.Instance.creatBitmap("asset.selectCP.Circle");
         _profile = ComponentFactory.Instance.creatComponentByStylename("selectCp.Profile");
         _scaleBack = ComponentFactory.Instance.creatCustomObject("selectCP.ScaleBack");
         _areaNameTxt = ComponentFactory.Instance.creatComponentByStylename("room.InstaneRight.recommendGrades");
         _recommendGrades = ComponentFactory.Instance.creatComponentByStylename("room.InstaneRight.recommendGrades");
         addChild(_viewPoint);
         _taskIconMc.gotoAndStop(1);
         var _loc1_:AdjustColor = new AdjustColor();
         _loc1_.brightness = 17;
         _loc1_.contrast = 8;
         _loc1_.hue = 0;
         _loc1_.saturation = 0;
         _adjustColorFilter = new ColorMatrixFilter(_loc1_.CalculateFinalFlatArray());
         _glowFilter = new GlowFilter(16639897,1,10,10,1.3);
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
         DoubleClickManager.Instance.enableDoubleClick(this);
         addEventListener("interactive_double_click",__mouseDoubleClick);
         addEventListener("interactive_click",__mouseClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         DoubleClickManager.Instance.disableDoubleClick(this);
         removeEventListener("interactive_double_click",__mouseDoubleClick);
         removeEventListener("interactive_click",__mouseClick);
      }
      
      private function showThewAlert() : Boolean
      {
         var _loc8_:TodayNotAlertFrame = null;
         var _loc7_:String = null;
         var _loc2_:String = null;
         var _loc3_:Boolean = PlayerManager.instance.currentPlayerModel.playerInfo.weary < 20;
         var _loc4_:Date = SharedManager.instance.thewCheckDate;
         var _loc5_:Date = new Date();
         var _loc1_:Boolean = false;
         var _loc6_:Boolean = Boolean(SharedManager.instance.thewCheck);
         if(!_loc6_ || _loc4_.month <= _loc4_.month && _loc4_.date < _loc5_.date)
         {
            _loc1_ = true;
         }
         if(_loc3_ && _loc1_)
         {
            _loc8_ = ComponentFactory.Instance.creatComponentByStylename("core.TodayNotAlertFrame");
            _loc7_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.disclist02");
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc8_.show(_loc7_,_loc2_,thewAlertBack);
            _loc8_.containerY = 36;
         }
         return _loc3_ && _loc1_;
      }
      
      private function thewAlertBack(param1:Boolean) : void
      {
         SharedManager.instance.thewCheck = param1;
         SharedManager.instance.thewCheckDate = new Date();
         SharedManager.instance.saveThewCheck();
         enter();
      }
      
      private function enter() : void
      {
         var _loc1_:CampaignTemplate = null;
         var _loc2_:Boolean = false;
         _loc1_ = _data.getMapByDifficult(1);
         if(CampaignRankManager.instance.rankDic[_loc1_.CampaignId] && CampaignRankManager.instance.rankDic[_loc1_.CampaignId].rank >= 5)
         {
            _loc2_ = true;
         }
         var _loc3_:Boolean = _data.getMapByDifficult(2) && _loc2_;
         var _loc4_:int = int(_loc3_ ? _data.getMapByDifficult(2).CampaignId : int(_data.getMapByDifficult(1).CampaignId));
         SingWarSocketSendManager.sendStartCampaignScene(_loc4_,1);
      }
      
      private function alertBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(showThewAlert())
            {
               return;
            }
            enter();
         }
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
      
      private function __mouseClick(param1:InteractiveEvent) : void
      {
         model.dispatchEvent(new SelectCampaignEvent("SELECTED_AREA_CHANGE",point));
      }
      
      private function __mouseDoubleClick(param1:InteractiveEvent) : void
      {
         var _loc4_:CampaignTemplate = null;
         var _loc5_:Boolean = false;
         model.point = point;
         model.selectedArea = _data;
         _loc4_ = _data.getMapByDifficult(1);
         if(CampaignRankManager.instance.rankDic[_loc4_.CampaignId] && CampaignRankManager.instance.rankDic[_loc4_.CampaignId].rank >= 5)
         {
            _loc5_ = true;
         }
         var _loc6_:Boolean = !!_data.getMapByDifficult(2) && _loc5_;
         var _loc7_:String = LanguageMgr.GetTranslation("selectcampaign.view.CampaignPointView.state01");
         var _loc8_:String = LanguageMgr.GetTranslation("selectcampaign.view.CampaignPointView.state02");
         var _loc9_:String = _loc6_ ? _loc7_ : _loc8_;
         SimpleAlertHelper.instance.data = [alertBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc10_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc11_:String = LanguageMgr.GetTranslation("selectcampaign.view.CampaignPointView.content",_data.areaName + _loc9_);
         SimpleAlertHelper.instance.popAlerFrame(_loc10_,_loc11_,_loc2_,_loc3_,false,true,true);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(selected || _state == "default")
         {
            return;
         }
         if(_viewContent)
         {
            _viewContent["build_icon"].filters = [_adjustColorFilter,_glowFilter];
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(selected || _state == "default")
         {
            return;
         }
         if(_viewContent)
         {
            _viewContent["build_icon"].filters = null;
         }
      }
      
      public function ExistDiff() : Boolean
      {
         var _loc1_:CampaignTemplate = null;
         var _loc2_:Boolean = false;
         if(_data == null)
         {
            return false;
         }
         _loc1_ = _data.getMapByDifficult(1);
         if(CampaignRankManager.instance.rankDic[_loc1_.CampaignId] && CampaignRankManager.instance.rankDic[_loc1_.CampaignId].rank >= 5)
         {
            _loc2_ = true;
         }
         return !!_data.getMapByDifficult(2) && _loc2_;
      }
      
      private function refreshView() : void
      {
         var _loc3_:Array = null;
         _hasTask = false;
         _effect.gotoAndStop(1);
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
            _recommendGrades.x = 45;
            _recommendGrades.text = "Nv " + _loc1_.MinLevel + "-" + _loc1_.MaxLevel;
            _recommendGrades.width = _recommendGrades.textWidth + 10;
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
               if(_data.getMapByDifficult(1).MinLevel > thane.grades)
               {
                  _state = "default";
                  mouseEnabled = false;
               }
            }
            if(_state == "over" || _state == "open" || _state == "default")
            {
               _loc3_ = TaskManage.instance.cate.mainTaskList;
               loop0:
               for each(var _loc2_:TaskTemplate in _loc3_)
               {
                  for each(var _loc4_:TaskCondictionTemplate in _loc2_.conditionList)
                  {
                     if(_loc4_.Para3 == _loc1_.CampaignId)
                     {
                        _hasTask = true;
                        break loop0;
                     }
                  }
               }
            }
            startLoad();
         }
      }
      
      private function startLoad() : void
      {
         clearViewContent();
         var _loc1_:String = PathManager.resourcePath + "swf/singlecampaign1/" + model.selectedChapter.chapterId + "/" + _data.areaId + ".swf";
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
            updateState();
         }
         if(_state != "default" && _state != "disable")
         {
            selected = _selected;
         }
         _data.viewContentLoaded = true;
         dispatchEvent(new SelectCampaignEvent("VIEW_CONTENT_LOADED"));
      }
      
      private function updateState() : void
      {
         var _loc1_:RankInfo = null;
         _viewContent.gotoAndStop(_state);
         if(_state == "open")
         {
            ObjectUtils.removeChildAllChildrenFromStage(_viewContent["backContain"]);
            ObjectUtils.removeChildAllChildrenFromStage(_viewContent["iconContain"]);
            _viewContent["iconContain"].addChildAt(_newIcon,0);
            _viewContent["backContain"].addChildAt(_scaleBack,0);
            updateInfoView();
         }
         else if(_state == "over")
         {
            ObjectUtils.removeChildAllChildrenFromStage(_viewContent["backContain"]);
            ObjectUtils.removeChildAllChildrenFromStage(_viewContent["iconContain"]);
            _viewContent["backContain"].addChild(_profile);
            _viewContent["backContain"].addChildAt(_circle,0);
            _viewContent["backContain"].addChildAt(_scaleBack,0);
            updateInfoView();
            _loc1_ = CampaignRankManager.instance.singleRankDic[_data.areaId];
            _profile.setFrame(_loc1_.rank);
         }
         else if(_state == "default")
         {
            ObjectUtils.removeChildAllChildrenFromStage(_viewContent["backContain"]);
            ObjectUtils.removeChildAllChildrenFromStage(_viewContent["iconContain"]);
            _viewContent["iconContain"].addChildAt(_newIcon,0);
            _viewContent["backContain"].addChildAt(_scaleBack,0);
            updateInfoView();
         }
         if(_hasTask)
         {
            _viewContent["iconContain"].addChild(_taskIconMc);
            _taskIconMc.gotoAndPlay(1);
            if(_tipsObject)
            {
               _tipsObject.x = this.x + _viewContent["iconContain"].x - _tipsObject.width / 2;
               _tipsObject.y = this.y + _viewContent["iconContain"].y - _tipsObject.height / 2;
               _tipsObject.visible = true;
            }
         }
         _viewPoint.addChild(_viewContent);
      }
      
      public function setTips(param1:Sprite) : void
      {
         _tipsObject = param1;
      }
      
      private function updateInfoView() : void
      {
         if(_viewContent["referencePoint"])
         {
            _scaleBack.width = _areaNameTxt.width + 30;
            _viewContent["iconContain"].x = _viewContent["backContain"].x = _viewContent["build_icon"].x + (_viewContent["build_icon"].width - _viewContent["backContain"].width) / 2 - 30;
            _viewContent["iconContain"].y = _viewContent["backContain"].y - 10;
            _viewContent["backContain"].addChild(_areaNameTxt);
            _viewContent["backContain"].addChild(_recommendGrades);
            _newIcon.x = _areaNameTxt.width - 10;
            _profile.x = _areaNameTxt.width + 14;
            _circle.x = _areaNameTxt.width;
            _recommendGrades.y = _scaleBack.y + 25;
            _areaNameTxt.y = _scaleBack.y + 7;
         }
         else
         {
            _viewContent["iconContain"].x = _viewContent["backContain"].x;
            _viewContent["iconContain"].y = _viewContent["backContain"].y;
            _viewContent["backContain"].addChild(_areaNameTxt);
            _viewContent["backContain"].addChild(_recommendGrades);
            _scaleBack.width = _areaNameTxt.width + 30;
            _scaleBack.x = -60;
            _recommendGrades.y = _scaleBack.y + 25;
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
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function clearViewContent() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onComplete);
         if(_scaleBack && _scaleBack.parent)
         {
            _scaleBack.parent.removeChild(_scaleBack);
         }
         if(_profile && _profile.parent)
         {
            _profile.parent.removeChild(_profile);
         }
         if(_circle && _circle.parent)
         {
            _circle.parent.removeChild(_circle);
         }
         if(_taskIconMc)
         {
            _taskIconMc.stop();
            if(_taskIconMc.parent)
            {
               _taskIconMc.parent.removeChild(_taskIconMc);
            }
         }
         if(_newIcon && _newIcon.parent)
         {
            _newIcon.parent.removeChild(_newIcon);
         }
         if(_viewContent && _viewContent["build_icon"])
         {
            _viewContent["build_icon"].filters = null;
         }
         if(_viewContent && _viewContent.parent)
         {
            _viewContent.parent.removeChild(_viewContent);
         }
         ObjectUtils.disposeViolentMc(_viewContent);
         _viewContent = null;
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearViewContent();
         ObjectUtils.disposeViolentMc(_viewPoint);
         _viewPoint = null;
         ObjectUtils.disposeViolentMc(_effect);
         _effect = null;
         ObjectUtils.disposeObject(_newIcon);
         _newIcon = null;
         ObjectUtils.disposeObject(_taskIconMc);
         _taskIconMc = null;
         ObjectUtils.disposeObject(_scaleBack);
         _scaleBack = null;
         ObjectUtils.disposeObject(_circle);
         _circle = null;
         ObjectUtils.disposeObject(_profile);
         _profile = null;
         ObjectUtils.disposeObject(_adjustColorFilter);
         _adjustColorFilter = null;
         ObjectUtils.disposeObject(_glowFilter);
         _glowFilter = null;
         _data = null;
         ObjectUtils.disposeAllChildren(this);
         if(_circle)
         {
            if(_circle.bitmapData)
            {
               _circle.bitmapData.dispose();
            }
            if(_circle.parent)
            {
               _circle.parent.removeChild(_circle);
            }
            _circle = null;
         }
         _glowFilter = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      private function isSpecialArea() : Boolean
      {
         if(data.areaId == 10701 || data.areaId == 10702)
         {
            return true;
         }
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
         var _loc2_:Point = null;
         _selected = param1;
         if(!_effect || !_viewContent)
         {
            return;
         }
         if(_selected)
         {
            _loc2_ = _viewContent.localToGlobal(new Point(_viewContent["circle"].x,_viewContent["circle"].y));
            _loc2_ = globalToLocal(_loc2_);
            if(isSpecialArea())
            {
               _effect.x = _loc2_.x + 92;
               _effect.y = _loc2_.y + 124;
            }
            else
            {
               _effect.x = _loc2_.x - 28;
               _effect.y = _loc2_.y - 15;
            }
            addChild(_effect);
            _effect.gotoAndPlay(1);
            _viewContent["build_icon"].filters = [_adjustColorFilter,_glowFilter];
            _viewContent.gotoAndStop(_state);
         }
         else
         {
            _viewContent["build_icon"].filters = null;
            _viewContent.gotoAndStop(_state);
         }
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return null;
      }
   }
}

