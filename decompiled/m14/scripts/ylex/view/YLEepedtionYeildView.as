package ylex.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.YLExpedtionManger;
   import mvc.module.children.ChildData;
   import mvc.module.ylex.ChildCampInfo;
   import mvc.module.ylex.YLExpedtionModel;
   import yishi.datas.templates.ChildCampTempTempInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class YLEepedtionYeildView extends Sprite
   {
      
      public var _alphaBg:Bitmap;
      
      public var _ydmainBg:MutipleImage;
      
      public var _ydLvBg2:MutipleImage;
      
      public var _gotoZZBtn:IconButton;
      
      public var _rewardZZBtn:IconButton;
      
      public var _ydzzExp:FilterFrameText;
      
      public var _ydzzState:FilterFrameText;
      
      public var _ydzzLeftTime:FilterFrameText;
      
      public var _ydzzRwBox:HBox;
      
      public var _ydzzSoild:ScaleFrameImage;
      
      private var levelMc:MovieClip;
      
      private var expText:FilterFrameText;
      
      private var headIcon:BaseIconView;
      
      private var _preTimeTxt:FilterFrameText;
      
      private var _time:TimeDownView;
      
      private var _data:ChildCampInfo;
      
      private var _currDesItem:YLExpedtionDesItem;
      
      private var _nextDesItem:YLExpedtionDesItem;
      
      public function YLEepedtionYeildView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get data() : ChildCampInfo
      {
         return _data;
      }
      
      public function set data(param1:ChildCampInfo) : void
      {
         var _loc5_:ChildCampTempTempInfo = null;
         var _loc4_:ChildCampTempTempInfo = null;
         var _loc9_:int = 0;
         var _loc2_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc7_:ChildData = null;
         var _loc8_:ChildTempInfo = null;
         _data = param1;
         if(_data != null)
         {
            _loc5_ = TempleteManager.instance.childCampTempCate.getTempByGrade(_data.grade);
            _loc4_ = TempleteManager.instance.childCampTempCate.getTempByGrade(_data.grade + 1);
            _loc2_ = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond * 1000;
            if(_data.startTime > 0)
            {
               _loc6_ = _data.startTime + _loc5_.StationedTime * 1000;
               _loc3_ = _loc6_ - _loc2_;
               if(_loc3_ < 0)
               {
                  _loc3_ = 0;
               }
               _time.visible = true;
               _time.timeCount = _loc3_ / 1000;
               _preTimeTxt.text = "";
            }
            _currDesItem.refreshView(_data.grade,_loc5_.Desc);
            if(!_loc4_)
            {
               _loc9_ = 100;
               expText.text = "Max";
               _ydLvBg2.visible = false;
               _nextDesItem.visible = false;
               _currDesItem.x = 336;
               _ydLvBg2.visible = false;
            }
            else
            {
               _currDesItem.x = 181;
               _nextDesItem.visible = true;
               _ydLvBg2.visible = true;
               _nextDesItem.refreshView(_data.grade + 1,_loc4_.Desc);
               _loc9_ = _data.nowExp * 100 / _loc5_.Exp;
               expText.text = _data.nowExp + "/" + _loc5_.Exp;
               _ydLvBg2.visible = true;
            }
            _ydzzState.text = "";
            levelMc.gotoAndStop(_loc9_);
            if(_data.childId == 0)
            {
               headIcon.visible = false;
               _ydzzSoild.visible = false;
               _gotoZZBtn.visible = true;
               _rewardZZBtn.visible = false;
            }
            else
            {
               headIcon.visible = true;
               _ydzzSoild.visible = true;
               _gotoZZBtn.visible = false;
               _loc7_ = ChildManager.instance.model.getChildById(_data.childId);
               upDatePreviewExp(_loc7_);
               _loc8_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc7_.job,_loc7_.growthGrade);
               if(_loc8_)
               {
                  headIcon.icon = PathManager.info.ResourcePath + "icon" + _loc8_.Icon;
                  headIcon.buttonMode = true;
                  headIcon.addEventListener("click",__removeChildFromListHandler);
               }
               _ydzzSoild.setFrame(_data.difficulty);
               if(_loc2_ > _data.startTime + _loc5_.StationedTime * 1000)
               {
                  _rewardZZBtn.visible = true;
               }
               else
               {
                  _rewardZZBtn.visible = false;
                  _ydzzState.text = LanguageMgr.GetTranslation("YLExpeditionItem.ruzhu.doingTip");
               }
            }
         }
      }
      
      private function upDatePreviewExp(param1:ChildData) : void
      {
         var _loc2_:int = param1.growthGrade * 1200;
         _ydzzExp.text = LanguageMgr.GetTranslation("YLExpeditionItem.zhuzha.exp",_loc2_);
      }
      
      private function get ylModel() : YLExpedtionModel
      {
         return YLExpedtionManger.instance.model;
      }
      
      private function __removeChildFromListHandler(param1:MouseEvent) : void
      {
         if(_data.childId > 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("YLExpeditionItem.ruzhu.doingTip"));
            return;
         }
         headIcon.visible = false;
         headIcon.removeEventListener("click",__removeChildFromListHandler);
         NotificationManager.instance.sendNotification("YLExpedtionModel.EVENT_SELECTED_DEL",_data.opChildData);
         _data.opChildData = null;
         _ydzzExp.text = LanguageMgr.GetTranslation("YLExpeditionItem.zhuzha.exp",0);
         _preTimeTxt.text = "";
         _time.visible = true;
      }
      
      private function initView() : void
      {
         _alphaBg = ComponentFactory.Instance.creatBitmap("asset.ylexdition.yd.alphaBg");
         _ydmainBg = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.ydmainBg");
         _ydLvBg2 = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.ydLvBg2");
         _gotoZZBtn = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.gotoZZBtn");
         _ydzzExp = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.ydzzExp");
         _ydzzState = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.ydzzState");
         _ydzzLeftTime = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.ydzzLeftTime");
         _ydzzRwBox = ComponentFactory.Instance.creatCustomObject("ui.ylexpedition.ydzzRwBox");
         _ydzzSoild = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.ydzzSoild");
         _rewardZZBtn = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedition.rewardZZBtn");
         levelMc = ComponentFactory.Instance.creatCustomObject("ui.ylexpedtion.ydexp.levelMc");
         expText = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpedtion.ydexpTxt");
         headIcon = ComponentFactory.Instance.creatCustomObject("ui.ylexpidtionyd.headIcon");
         _preTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpidtionyd.preTimeTxt");
         _time = ComponentFactory.Instance.creatComponentByStylename("ui.ylexpidtionyd.UpdateTime");
         _currDesItem = new YLExpedtionDesItem(1);
         _nextDesItem = new YLExpedtionDesItem(2);
         addChild(_alphaBg);
         addChild(_ydmainBg);
         addChild(_ydLvBg2);
         addChild(_gotoZZBtn);
         addChild(_ydzzExp);
         addChild(_ydzzState);
         addChild(_ydzzLeftTime);
         addChild(_ydzzRwBox);
         addChild(headIcon);
         addChild(_ydzzSoild);
         addChild(_rewardZZBtn);
         addChild(levelMc);
         addChild(expText);
         addChild(_time);
         addChild(_preTimeTxt);
         addChild(_currDesItem);
         addChild(_nextDesItem);
         _time.timeCount = 0;
         expText.text = "Max";
         _rewardZZBtn.visible = false;
         _ydzzSoild.visible = false;
         levelMc.gotoAndStop(1);
         _ydzzLeftTime.text = LanguageMgr.GetTranslation("YLExpeditionItem.zhuzha.leftTime");
         _ydzzExp.text = LanguageMgr.GetTranslation("YLExpeditionItem.zhuzha.exp",0);
         _currDesItem.x = 181;
         _currDesItem.y = 141;
         _nextDesItem.x = 442;
         _nextDesItem.y = 141;
      }
      
      private function initEvent() : void
      {
         _gotoZZBtn.addEventListener("click",gotozzClickHandler);
         _rewardZZBtn.addEventListener("click",gotoRewardClickHandler);
         NotificationManager.instance.addEventListener("YLExpedtionModel.EVENT_SELECTED_ADD",selectedAddHandler);
         _time.addEventListener("timerDown_complete",timeCompleteHandler);
      }
      
      private function removeEvent() : void
      {
         _gotoZZBtn.removeEventListener("click",gotozzClickHandler);
         _rewardZZBtn.removeEventListener("click",gotoRewardClickHandler);
         headIcon.removeEventListener("click",__removeChildFromListHandler);
         NotificationManager.instance.removeEventListener("YLExpedtionModel.EVENT_SELECTED_ADD",selectedAddHandler);
         _time.removeEventListener("timerDown_complete",timeCompleteHandler);
      }
      
      private function timeCompleteHandler(param1:Event) : void
      {
         _rewardZZBtn.visible = true;
         _ydzzState.text = "";
      }
      
      private function selectedAddHandler(param1:NotificationEvent) : void
      {
         var _loc4_:Number = NaN;
         var _loc2_:ChildData = param1.data as ChildData;
         upDatePreviewExp(_loc2_);
         var _loc5_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_loc2_.job,_loc2_.growthGrade);
         if(_loc5_)
         {
            headIcon.visible = true;
            headIcon.icon = PathManager.info.ResourcePath + "icon" + _loc5_.Icon;
            headIcon.buttonMode = true;
            headIcon.addEventListener("click",__removeChildFromListHandler);
            _data.opChildData = _loc2_;
         }
         var _loc3_:ChildCampTempTempInfo = TempleteManager.instance.childCampTempCate.getTempByGrade(_data.grade);
         if(_loc3_)
         {
            _loc4_ = Number(_loc3_.StationedTime);
            _preTimeTxt.text = DateFormatter.getCountDate(_loc4_,2,3);
            _time.visible = false;
         }
      }
      
      private function gotozzClickHandler(param1:MouseEvent) : void
      {
         if(_data == null || _data.opChildData == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("YLExpeditionItem.doZhuzha"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("ylexpedition",3,_data);
      }
      
      private function gotoRewardClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("ylexpedition",5,_data);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_alphaBg);
         _alphaBg = null;
         ObjectUtils.disposeObject(_ydmainBg);
         _ydmainBg = null;
         ObjectUtils.disposeObject(_ydLvBg2);
         _ydLvBg2 = null;
         ObjectUtils.disposeObject(_gotoZZBtn);
         _gotoZZBtn = null;
         ObjectUtils.disposeObject(_ydzzExp);
         _ydzzExp = null;
         ObjectUtils.disposeObject(_ydzzState);
         _ydzzState = null;
         ObjectUtils.disposeObject(_ydzzLeftTime);
         _ydzzLeftTime = null;
         ObjectUtils.disposeObject(_ydzzRwBox);
         _ydzzRwBox = null;
         ObjectUtils.disposeObject(_ydzzSoild);
         _ydzzSoild = null;
         ObjectUtils.disposeObject(_rewardZZBtn);
         _rewardZZBtn = null;
         ObjectUtils.disposeObject(expText);
         expText = null;
         ObjectUtils.disposeObject(headIcon);
         headIcon = null;
         if(levelMc)
         {
            ObjectUtils.disposeViolentMc(levelMc);
         }
         levelMc = null;
         if(_time)
         {
            ObjectUtils.disposeObject(_time);
         }
         _time = null;
         ObjectUtils.disposeObject(_preTimeTxt);
         _preTimeTxt = null;
         ObjectUtils.disposeObject(_currDesItem);
         _currDesItem = null;
         ObjectUtils.disposeObject(_nextDesItem);
         _nextDesItem = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_data)
         {
            _data.opChildData = null;
         }
         _data = null;
      }
   }
}

