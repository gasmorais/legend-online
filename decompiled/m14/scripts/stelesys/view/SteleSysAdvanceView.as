package stelesys.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SteleSysManager;
   import mvc.module.stele.StelaAttInfo;
   import mvc.module.stele.StelesysInfo;
   import mvc.module.stele.StelesysModel;
   import stelesys.item.StelaAdvanceChooseItem;
   import stelesys.item.StelaStepChooseBoxItem;
   import stelesys.item.StelesysAdvancTxtItem;
   import stelesys.item.StelesysNameAndValueTxt;
   import yishi.datas.templates.StelaStepTemplateInfo;
   import yishi.datas.templates.StelaTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.base.PageBar;
   
   public class SteleSysAdvanceView extends Component
   {
      
      private var _bg:MovieClip;
      
      private var _advanceBtn:IconButton;
      
      private var _bagView:StelesysBagView;
      
      private var _att1:StelesysNameAndValueTxt;
      
      private var _att2:StelesysNameAndValueTxt;
      
      private var _upMc:MovieClip;
      
      private var _skillItem:VBox;
      
      private var _skillList:Array = [];
      
      private var _stepItem:StelaStepChooseBoxItem;
      
      private var _chooseItem:StelaAdvanceChooseItem;
      
      private var _currInfo:StelesysInfo;
      
      private var _currInfoList:Array;
      
      private var _currGradeItem:StelesysAdvancTxtItem;
      
      private var _currRefineItem:StelesysAdvancTxtItem;
      
      private var _maxFlg:Bitmap;
      
      private var _ids:Array = [];
      
      private var _needBit:Bitmap;
      
      private var _needTxt:FilterFrameText;
      
      private var _nextInfo:StelesysInfo;
      
      private var _pageBar:PageBar;
      
      private var _needMetrailTxt:FilterFrameText;
      
      public function SteleSysAdvanceView()
      {
         super();
         initView();
         initEvent();
         refreshView(true);
      }
      
      private function initView() : void
      {
         var _loc1_:StelesysAdvancTxtItem = null;
         var _loc2_:int = 0;
         _nextInfo = new StelesysInfo();
         _bg = ComponentFactory.Instance.creatCustomObject("asset.stele.stepBg");
         _advanceBtn = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.stepDoBtn");
         _bagView = ComponentFactory.Instance.creatCustomObject("stelesys.advance.bagView");
         _upMc = ComponentFactory.Instance.creatCustomObject("asset.stelesys.upMc");
         _skillItem = ComponentFactory.Instance.creatCustomObject("ui.stela.advance.skillItem");
         _stepItem = ComponentFactory.Instance.creatCustomObject("ui.stela.advance.stepItem");
         _chooseItem = ComponentFactory.Instance.creatCustomObject("ui.stela.advance.chooseItem");
         _currGradeItem = ComponentFactory.Instance.creatCustomObject("ui.stela.advance.currGradeItem");
         _currRefineItem = ComponentFactory.Instance.creatCustomObject("ui.stela.advance.currRefineItem");
         _maxFlg = ComponentFactory.Instance.creatBitmap("asset.stela.adMax");
         _needBit = ComponentFactory.Instance.creatBitmap("asset.stela.ad1");
         _needTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.advanceNeedTxt");
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.advance.PageBar");
         _needMetrailTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stela.advanceNeedMetrailTxt");
         addChild(_bg);
         addChild(_advanceBtn);
         addChild(_bagView);
         addChild(_pageBar);
         addChild(_skillItem);
         addChild(_stepItem);
         addChild(_chooseItem);
         addChild(_currGradeItem);
         addChild(_currRefineItem);
         addChild(_maxFlg);
         addChild(_needBit);
         addChild(_needTxt);
         addChild(_needMetrailTxt);
         addChild(_upMc);
         _skillItem.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new StelesysAdvancTxtItem();
            _skillList[_loc2_] = _loc1_;
            _skillItem.addChild(_loc1_);
            _loc2_++;
         }
         _skillItem.commitChanges();
         _advanceBtn.enable = false;
         _upMc.mouseEnabled = false;
         _maxFlg.visible = false;
         _currGradeItem.visible = false;
         _currRefineItem.visible = false;
         _skillItem.visible = false;
         _upMc.gotoAndStop(25);
         _currGradeItem.type = 1;
         _currRefineItem.type = 2;
         _needTxt.text = "0/0";
      }
      
      override public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:StelesysAdvancTxtItem in _skillList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         ObjectUtils.disposeObject(_skillItem);
         _skillItem = null;
         ObjectUtils.disposeObject(_advanceBtn);
         _advanceBtn = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         ObjectUtils.disposeViolentMc(_bg);
         _bg = null;
         ObjectUtils.disposeViolentMc(_upMc);
         _upMc = null;
         ObjectUtils.disposeObject(_skillItem);
         _skillItem = null;
         ObjectUtils.disposeObject(_stepItem);
         _stepItem = null;
         ObjectUtils.disposeObject(_chooseItem);
         _chooseItem = null;
         ObjectUtils.disposeObject(_currGradeItem);
         _currGradeItem = null;
         ObjectUtils.disposeObject(_currRefineItem);
         _currRefineItem = null;
         ObjectUtils.disposeObject(_maxFlg);
         _maxFlg = null;
         ObjectUtils.disposeObject(_needBit);
         _needBit = null;
         ObjectUtils.disposeObject(_needTxt);
         _needTxt = null;
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         ObjectUtils.disposeObject(_needMetrailTxt);
         _needMetrailTxt = null;
         model.currAdvanceInfo = null;
         super.dispose();
         _currInfo = null;
         _currInfoList = null;
         _skillList = null;
         _ids = null;
         _nextInfo = null;
      }
      
      private function get model() : StelesysModel
      {
         return SteleSysManager.Ins.model;
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("STELE_SYS_CHOOSE",changeHandler);
         NotificationManager.instance.addEventListener("STELE_SYS_UPDATA",updateHandler);
         NotificationManager.instance.addEventListener("STELE_SYS_METRIAL",updateMetrailHandler);
         _advanceBtn.addEventListener("click",advanceBtnHandler);
         _pageBar.addEventListener("change",pageChangeHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("STELE_SYS_CHOOSE",changeHandler);
         NotificationManager.instance.removeEventListener("STELE_SYS_UPDATA",updateHandler);
         NotificationManager.instance.removeEventListener("STELE_SYS_METRIAL",updateMetrailHandler);
         _advanceBtn.removeEventListener("click",advanceBtnHandler);
         _pageBar.removeEventListener("change",pageChangeHandler);
      }
      
      private function pageChangeHandler(param1:Event) : void
      {
         _bagView.refreshView(_pageBar.getCurPageDatas());
         updateMetrailHandler();
      }
      
      private function advanceBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         _advanceBtn.enable = false;
         _ids.length = 0;
         for each(var _loc7_:StelesysInfo in _currInfoList)
         {
            if(_loc7_.isChoose)
            {
               _ids.push(_loc7_.id);
               if(_loc7_.totalExp > 0)
               {
                  _loc2_ = true;
               }
            }
         }
         if(_loc2_)
         {
            _loc3_ = LanguageMgr.GetTranslation("public.confirm");
            _loc4_ = LanguageMgr.GetTranslation("public.cancel");
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc6_ = LanguageMgr.GetTranslation("stela.advance.tip");
            SimpleAlertHelper.instance.data = [__alertResponse,_ids.concat()];
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc6_,_loc3_,_loc4_,false,true);
         }
         else
         {
            SteleSysManager.Ins.sendStep(_currInfo.id,_ids.concat());
         }
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean, param3:Array) : void
      {
         if(param1)
         {
            SteleSysManager.Ins.sendStep(_currInfo.id,param3);
         }
      }
      
      private function updateMetrailHandler(param1:NotificationEvent = null) : void
      {
         var _loc2_:Function = null;
         if(_currInfo == null || _currInfo.nextStepTempInfo == null)
         {
            return;
         }
         if(param1)
         {
            _loc2_ = param1.data as Function;
         }
         var _loc3_:int = 0;
         for each(var _loc4_:StelesysInfo in _currInfoList)
         {
            if(_loc4_.isChoose)
            {
               _loc3_++;
            }
         }
         var _loc5_:int = int(_currInfo.nextStepTempInfo.CostNum);
         if(_loc3_ > _loc5_)
         {
            _loc3_ = _loc5_;
            if(_loc2_ != null)
            {
               _loc2_();
            }
         }
         _advanceBtn.enable = _loc3_ >= _loc5_;
         if(_advanceBtn.enable)
         {
            _needTxt.htmlText = LanguageMgr.GetTranslation("stela.advance.ok",_loc3_,_loc5_);
         }
         else
         {
            _needTxt.htmlText = LanguageMgr.GetTranslation("stela.advance.no",_loc3_,_loc5_);
         }
      }
      
      private function updateHandler(param1:NotificationEvent) : void
      {
         if(_currInfo == null)
         {
            return;
         }
         _upMc.gotoAndPlay(1);
         _stepItem.data = _currInfo;
         refreshNextItem();
         refreshGrades();
         refreshSkills();
         refreshView();
      }
      
      private function changeHandler(param1:NotificationEvent) : void
      {
         var _loc2_:StelesysInfo = param1.data as StelesysInfo;
         _currInfo = _loc2_;
         model.currAdvanceInfo = _currInfo;
         _stepItem.data = _currInfo;
         refreshNextItem();
         refreshGrades();
         refreshSkills();
         refreshView();
      }
      
      private function refreshNextItem() : void
      {
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:StelaTemplateInfo = null;
         var _loc3_:StelaStepTemplateInfo = null;
         var _loc6_:String = null;
         var _loc7_:int = 0;
         if(_currInfo == null)
         {
            return;
         }
         var _loc1_:StelaStepTemplateInfo = _currInfo.nextStepTempInfo;
         if(_loc1_ == null)
         {
            _advanceBtn.visible = false;
            _needBit.visible = false;
            _maxFlg.visible = true;
            _needTxt.visible = false;
            _currGradeItem.visible = false;
            _currRefineItem.visible = false;
            _skillItem.visible = false;
            _chooseItem.data = null;
            _needMetrailTxt.text = "";
            return;
         }
         _needTxt.htmlText = LanguageMgr.GetTranslation("stela.advance.no",0,_currInfo.nextStepTempInfo.CostNum);
         _advanceBtn.visible = true;
         _maxFlg.visible = false;
         _needBit.visible = true;
         _needTxt.visible = true;
         _currGradeItem.visible = true;
         _currRefineItem.visible = true;
         _skillItem.visible = true;
         _loc2_ = int(_currInfo.nextStepTempInfo.CostItem);
         _loc5_ = int(_currInfo.nextStepTempInfo.CostItemStep);
         _loc4_ = TempleteManager.instance.stelaTempCate.getTemplateById(_loc2_);
         _loc3_ = TempleteManager.instance.stelaStepTempCate.getTemplateById(_loc2_,_loc5_);
         if(_loc4_ && _loc3_)
         {
            _loc6_ = "";
            _loc7_ = int(_loc3_.Profile);
            _loc6_ = StringHelper.format("<font color={0}>{1}</font>",GoodsHelp.getGoodColorString(_loc7_ > 0 ? _loc7_ : 1),_loc4_.TemplateName);
            _needMetrailTxt.htmlText = LanguageMgr.GetTranslation("stela.advance.metrialTip",_loc4_.Rarity,_loc5_,_loc6_);
         }
         _nextInfo.id = _currInfo.id;
         _nextInfo.templateId = _currInfo.templateId;
         _nextInfo.pos = _currInfo.pos;
         _nextInfo.step = _currInfo.step + 1;
         _nextInfo.level = _currInfo.level;
         _nextInfo.exp = _currInfo.exp;
         _nextInfo.totalExp = _currInfo.totalExp;
         _nextInfo.skill1 = _currInfo.skill1;
         _nextInfo.skill2 = _currInfo.skill2;
         _nextInfo.skill3 = _currInfo.skill3;
         _nextInfo.skill4 = _currInfo.skill4;
         _nextInfo.skill5 = _currInfo.skill5;
         _nextInfo.isExist = _currInfo.isExist;
         _nextInfo.updateStelaAttInfo();
         _chooseItem.data = _nextInfo;
      }
      
      private function refreshSkills() : void
      {
         var _loc3_:StelesysAdvancTxtItem = null;
         var _loc7_:String = null;
         var _loc6_:int = 0;
         if(_currInfo == null)
         {
            return;
         }
         var _loc1_:StelaStepTemplateInfo = _currInfo.nextStepTempInfo;
         if(_loc1_ == null)
         {
            return;
         }
         var _loc4_:StelaAttInfo = new StelaAttInfo();
         var _loc2_:StelaStepTemplateInfo = _currInfo.stepTempInfo;
         _loc4_.Attack = _loc2_.Attack;
         _loc4_.Defence = _loc2_.Defence;
         _loc4_.MagicAttack = _loc2_.MagicAttack;
         _loc4_.MagicDefence = _loc2_.MagicDefence;
         _loc4_.Live = _loc2_.Live;
         _loc4_.ForceHit = _loc2_.ForceHit;
         _loc4_.Parry = _loc2_.Parry;
         _loc4_.Penetrate = _loc2_.Penetrate;
         _loc4_.ReduceResiAgainst = _loc2_.ReduceResiAgainst;
         _loc4_.ResiPenetrate = _loc2_.ResiPenetrate;
         var _loc5_:Array = _loc4_.hasValueAtt;
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            _loc7_ = _loc5_[_loc6_];
            _loc3_ = _skillList[_loc6_];
            _loc3_.nameTxt = _loc7_;
            _loc3_.refreshView(_loc2_[_loc7_],_loc1_[_loc7_]);
            _loc6_++;
         }
      }
      
      private function refreshView(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _currInfoList = model.allStelaList;
            _loc2_ = 1;
         }
         else
         {
            _currInfoList = model.getSomeStepAndId(_currInfo);
            _loc2_ = int(_pageBar.getCurPage());
         }
         model.doSort(_currInfoList);
         _pageBar.setAutoPagingData(_currInfoList,40);
         _pageBar.setCurPage(_loc2_);
         refreshGrades();
      }
      
      private function refreshGrades() : void
      {
         if(_currInfo == null)
         {
            return;
         }
         _advanceBtn.enable = false;
         var _loc1_:int = int(_currInfo.stepTempInfo.StrengthLimit);
         var _loc2_:int = int(_currInfo.stepTempInfo.BaptizeLimit);
         if(_currInfo.nextStepTempInfo)
         {
            _loc1_ = int(_currInfo.nextStepTempInfo.StrengthLimit);
            _loc2_ = int(_currInfo.nextStepTempInfo.BaptizeLimit);
         }
         _currGradeItem.refreshView(_currInfo.stepTempInfo.StrengthLimit,_loc1_);
         _currRefineItem.refreshView(_currInfo.stepTempInfo.BaptizeLimit,_loc2_);
      }
   }
}

