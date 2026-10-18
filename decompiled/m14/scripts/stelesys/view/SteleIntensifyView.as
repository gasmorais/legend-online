package stelesys.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SteleSysManager;
   import mvc.module.stele.StelaAttInfo;
   import mvc.module.stele.StelesysInfo;
   import mvc.module.stele.StelesysModel;
   import stelesys.item.StelesysIntensifyBox;
   import stelesys.item.StelesysNameAndValueTxt;
   import yishi.datas.templates.StelaPropertyTemplateInfo;
   import yishi.datas.templates.StelaStepTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.FlickerHelper;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.base.PageBar;
   import yishi.view.base.ProgressPanel;
   import yishi.view.base.TextAddBitmap;
   import yishi.view.tips.MessageTipManager;
   
   public class SteleIntensifyView extends Component
   {
      
      private var _mbg:Bitmap;
      
      private var _intensifyItem:StelesysIntensifyBox;
      
      private var _currBg:Bitmap;
      
      private var _currLine:Bitmap;
      
      private var _arrow:Image;
      
      private var _progress:ProgressPanel;
      
      private var _lvTxt:FilterFrameText;
      
      private var _currAttBox:VBox;
      
      private var _currList:Array = [];
      
      private var _nextAttBox:VBox;
      
      private var _nextList:Array = [];
      
      private var _intensifyBtn:IconButton;
      
      private var _oneKeyBtn:IconButton;
      
      private var _menu:SteleSysChooseMenu;
      
      private var _bagView:StelesysIntensifyBagView;
      
      private var _needUpStepFlg:Bitmap;
      
      private var _fullLevelFlg:Bitmap;
      
      private var _currInfoList:Array;
      
      private var _currInfo:StelesysInfo;
      
      private var _scrollSp:Sprite;
      
      private var _pageBar:PageBar;
      
      private var _bitTxt:TextAddBitmap;
      
      private var _ccount:int;
      
      private var _addLvTxt:TextAddBitmap;
      
      private var _proContent:Sprite;
      
      public function SteleIntensifyView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _mbg = ComponentFactory.Instance.creatBitmap("asset.stelesys.intensifyBg");
         _menu = ComponentFactory.Instance.creatCustomObject("stelesys.IntensifyMenu");
         _bagView = ComponentFactory.Instance.creatCustomObject("stelesys.intensify.bagView");
         _arrow = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.IntensifyArrow");
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.intensify.PageBar");
         _bitTxt = ComponentFactory.Instance.creatCustomObject("ui.stela.intensifyBitTxt");
         _bitTxt.initView("ui.stelesys.intensifySortTxt","asset.stela.intensifyCNum");
         _bitTxt.adjustPositionY(7);
         _addLvTxt = ComponentFactory.Instance.creatCustomObject("ui.stela.intensifyAddLvTxt");
         _addLvTxt.initView("ui.stelesys.intensifyAddLvTxt","asset.stelesys.addImage");
         _addLvTxt.adjustPositionY(0);
         _addLvTxt.visible = false;
         _currBg = ComponentFactory.Instance.creatBitmap("asset.stelesys.intensify.currBg");
         _currLine = ComponentFactory.Instance.creatBitmap("asset.stelesys.intensifyLine");
         _intensifyItem = ComponentFactory.Instance.creatCustomObject("stelesys.intensify.currItem");
         _progress = ComponentFactory.Instance.creatCustomObject("stelesys.intensify.progressHBar");
         _currAttBox = ComponentFactory.Instance.creatCustomObject("stelesys.intensify.AttVbox1");
         _nextAttBox = ComponentFactory.Instance.creatCustomObject("stelesys.intensify.AttVbox2");
         _intensifyBtn = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.intensifyDoBtn");
         _oneKeyBtn = ComponentFactory.Instance.creatComponentByStylename("stela.intensify.oneKeyBtn");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.intensifyLvTxt");
         _needUpStepFlg = ComponentFactory.Instance.creatBitmap("asset.stelesys.canTensifyFlg");
         _fullLevelFlg = ComponentFactory.Instance.creatBitmap("asset.stelesys.fullIntensifyFlg");
         _progress.initView("asset.stelesys.progressBack","asset.stelesys.progressBar","ui.stelesys.intensifyProTxt","asset.stelesys.progressPreBar");
         _scrollSp = new Sprite();
         _proContent = new Sprite();
         addChild(_mbg);
         addChild(_bagView);
         addChild(_bitTxt);
         addChild(_pageBar);
         addChild(_currBg);
         addChild(_currLine);
         addChild(_intensifyItem);
         addChild(_intensifyBtn);
         addChild(_oneKeyBtn);
         addChild(_needUpStepFlg);
         addChild(_fullLevelFlg);
         addChild(_scrollSp);
         addChild(_proContent);
         addChild(_menu);
         _scrollSp.addChild(_currAttBox);
         _scrollSp.addChild(_arrow);
         _scrollSp.addChild(_nextAttBox);
         _proContent.addChild(_progress);
         _proContent.addChild(_addLvTxt);
         _proContent.addChild(_lvTxt);
         _needUpStepFlg.visible = false;
         _fullLevelFlg.visible = false;
         _intensifyBtn.visible = false;
         _oneKeyBtn.visible = false;
         _scrollSp.x = 45;
         _scrollSp.y = 243;
         _progress.setValueText("0/0");
         _lvTxt.text = "0";
         _bitTxt.setText("0");
         var _loc1_:String = "1|1|1|1|1|1,1|1|1|1|1|1";
         model.changeIntensifyStr(_loc1_);
         _menu.menuType = 2;
         _menu.refreshSwitchMenuName(_loc1_);
         creatCurrAtts();
         creatNextAtts();
      }
      
      private function refreshView() : void
      {
         var _loc1_:int = 0;
         FlickerHelper.clearFilcker(_proContent);
         if(_addLvTxt)
         {
            _addLvTxt.visible = false;
         }
         _currInfoList = model.noUpStelaList;
         if(_currInfo)
         {
            _loc1_ = _currInfoList.indexOf(_currInfo);
            if(_loc1_ != -1)
            {
               _currInfoList.splice(_loc1_,1);
            }
         }
         var _loc2_:StelaSwitchObj = _menu.switchObj;
         _currInfoList = model.doSwitch(_currInfoList,_loc2_.stars,_loc2_.colors);
         model.doSort(_currInfoList,true);
         _pageBar.setAutoPagingData(_currInfoList,40);
         _pageBar.setCurPage(1);
         _ccount = _currInfoList.length;
         _bitTxt.setText("0/" + _ccount);
      }
      
      private function refreshView2() : void
      {
         var _loc1_:int = 0;
         FlickerHelper.clearFilcker(_proContent);
         if(_addLvTxt)
         {
            _addLvTxt.visible = false;
         }
         if(_currInfoList)
         {
            model.fliterExsit(_currInfoList);
            _pageBar.setAutoPagingData(_currInfoList,40);
            _loc1_ = int(_pageBar.getCurPage());
            _pageBar.setCurPage(_loc1_);
            _ccount = _currInfoList.length;
            _bitTxt.setText("0/" + _ccount);
         }
      }
      
      private function creatCurrAtts() : void
      {
         var _loc1_:StelesysNameAndValueTxt = null;
         var _loc3_:String = null;
         var _loc2_:int = 0;
         _currAttBox.beginChanges();
         var _loc4_:Array = [];
         _loc4_.push("Attack");
         _loc4_.push("Defence");
         _loc4_.push("MagicAttack");
         _loc4_.push("MagicDefence");
         _loc4_.push("Live");
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = _loc4_[_loc2_];
            _loc1_ = new StelesysNameAndValueTxt("ui.stelesys.attNameTxt","ui.stelesys.attValueTxt");
            _currAttBox.addChild(_loc1_);
            _currList[_loc2_] = _loc1_;
            _loc1_.nameTxt = _loc3_;
            _loc1_.valueTxt = 0;
            _loc2_++;
         }
         _currAttBox.commitChanges();
      }
      
      private function creatNextAtts() : void
      {
         var _loc1_:StelesysNameAndValueTxt = null;
         var _loc3_:String = null;
         var _loc2_:int = 0;
         _nextAttBox.beginChanges();
         var _loc4_:Array = [];
         _loc4_.push("Attack");
         _loc4_.push("Defence");
         _loc4_.push("MagicAttack");
         _loc4_.push("MagicDefence");
         _loc4_.push("Live");
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = _loc4_[_loc2_];
            _loc1_ = new StelesysNameAndValueTxt("ui.stelesys.attNameTxt2","ui.stelesys.attValueTxt2");
            _nextAttBox.addChild(_loc1_);
            _nextList[_loc2_] = _loc1_;
            _loc1_.nameTxt = _loc3_;
            _loc1_.valueTxt = -1;
            _loc2_++;
         }
         _nextAttBox.commitChanges();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         FlickerHelper.clearFilcker(_proContent);
         ObjectUtils.disposeObject(_mbg);
         _mbg = null;
         ObjectUtils.disposeObject(_menu);
         _menu = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         ObjectUtils.disposeObject(_currBg);
         _currBg = null;
         ObjectUtils.disposeObject(_currLine);
         _currLine = null;
         ObjectUtils.disposeObject(_intensifyItem);
         _intensifyItem = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_currAttBox);
         _currAttBox = null;
         ObjectUtils.disposeObject(_nextAttBox);
         _nextAttBox = null;
         ObjectUtils.disposeObject(_lvTxt);
         _lvTxt = null;
         ObjectUtils.disposeObject(_arrow);
         _arrow = null;
         ObjectUtils.disposeObject(_intensifyBtn);
         _intensifyBtn = null;
         ObjectUtils.disposeObject(_oneKeyBtn);
         _oneKeyBtn = null;
         ObjectUtils.disposeObject(_scrollSp);
         _scrollSp = null;
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         ObjectUtils.disposeObject(_bitTxt);
         _bitTxt = null;
         ObjectUtils.disposeObject(_addLvTxt);
         _addLvTxt = null;
         model.currIntensifyInfo = null;
         model.currIntensifyBagList = null;
         super.dispose();
         _currList = null;
         _nextList = null;
         _currInfoList = null;
         _currInfo = null;
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("STELE_SYS_CHOOSE",changeHandler);
         NotificationManager.instance.addEventListener("STELE_SYS_UPDATA",updateHandler);
         NotificationManager.instance.addEventListener("STELE_SYS_METRIAL",updatePreProgressHandler);
         NotificationManager.instance.addEventListener("STELE_SYS_SWITCH",switchViewHandler);
         NotificationManager.instance.addEventListener("STELE_SYS_USE",updatePreProgressHandler);
         _intensifyBtn.addEventListener("click",clickIntensifyHandler);
         _oneKeyBtn.addEventListener("click",clickOneKeyHandler);
         _pageBar.addEventListener("change",pageChangeHandler);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("STELE_SYS_CHOOSE",changeHandler);
         NotificationManager.instance.removeEventListener("STELE_SYS_UPDATA",updateHandler);
         NotificationManager.instance.removeEventListener("STELE_SYS_METRIAL",updatePreProgressHandler);
         NotificationManager.instance.removeEventListener("STELE_SYS_SWITCH",switchViewHandler);
         NotificationManager.instance.removeEventListener("STELE_SYS_USE",updatePreProgressHandler);
         _intensifyBtn.removeEventListener("click",clickIntensifyHandler);
         _oneKeyBtn.removeEventListener("click",clickOneKeyHandler);
         _pageBar.removeEventListener("change",pageChangeHandler);
      }
      
      private function pageChangeHandler(param1:Event) : void
      {
         var _loc2_:Array = _pageBar.getCurPageDatas();
         var _loc3_:Array = model.metrialStelaList;
         _bagView.refreshViewII(_loc3_,_loc2_);
         model.currIntensifyBagList = _loc2_;
         _bitTxt.setText("0/" + _ccount);
      }
      
      private function switchViewHandler(param1:NotificationEvent) : void
      {
         _menu.refreshSwitchMenuName(model.currIntensifyStr);
         refreshView();
         refreshProgress(_currInfo);
      }
      
      private function clickOneKeyHandler(param1:MouseEvent) : void
      {
         model.autoIntensifyChoose();
         _bagView.opUpdate();
         _progress.previewValue(_currInfo.exp + model.currInstensifyPreExp);
         _bitTxt.setText(model.instensifyChooseNum + "/" + _ccount);
         checkUpLvState(model.currInstensifyPreExp);
      }
      
      private function clickIntensifyHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc4_:String = null;
         var _loc6_:Array = [];
         var _loc5_:Boolean = false;
         for each(var _loc9_:StelesysInfo in _currInfoList)
         {
            if(_loc9_.isChoose)
            {
               _loc6_.push(_loc9_.id);
               if(_loc9_.star >= 4)
               {
                  _loc5_ = true;
               }
            }
         }
         if(_loc5_)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc7_ = LanguageMgr.GetTranslation("public.prompt");
            _loc8_ = LanguageMgr.GetTranslation("stela.intensify.starTip");
            SimpleAlertHelper.instance.data = [__alertResponse,_loc6_];
            SimpleAlertHelper.instance.popAlerFrame(_loc7_,_loc8_,_loc2_,_loc3_,false,true);
         }
         else
         {
            _loc4_ = _bagView.useMetrial;
            if(_loc6_.length > 0 || _loc4_ != "")
            {
               SteleSysManager.Ins.sendIntensify(_currInfo.id,_loc4_,_loc6_);
            }
            else
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("stela.intensify.needMetrail"));
            }
         }
      }
      
      private function __alertResponse(param1:Boolean, param2:Boolean, param3:Array) : void
      {
         var _loc4_:String = null;
         if(param1)
         {
            _loc4_ = _bagView.useMetrial;
            if(param3.length > 0 || _loc4_ != "")
            {
               SteleSysManager.Ins.sendIntensify(_currInfo.id,_loc4_,param3);
            }
         }
      }
      
      private function updatePreProgressHandler(param1:NotificationEvent) : void
      {
         if(_currInfo && _currInfo.level == _currInfo.stepTempInfo.StrengthLimit)
         {
            return;
         }
         model.intensifyCheckChoose();
         _progress.previewValue(_currInfo.exp + model.currInstensifyPreExp);
         _bitTxt.setText(model.instensifyChooseNum + "/" + _ccount);
         checkUpLvState(model.currInstensifyPreExp);
      }
      
      private function checkUpLvState(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _currInfo.totalExp + param1;
         if(param1 <= 0)
         {
            _addLvTxt.visible = false;
            FlickerHelper.clearFilcker(_proContent);
            preViewAtt(_currInfo.templateId,_currInfo.level + 1,_currInfo.step);
         }
         else
         {
            _loc3_ = int(TempleteManager.instance.stelaPropertyTempCate.getCeilLvByExp(_currInfo.templateId,_currInfo.level,_loc2_));
            if(_loc3_ > _currInfo.level)
            {
               _addLvTxt.visible = true;
               _addLvTxt.setText("" + _loc3_);
               FlickerHelper.clearFilcker(_proContent);
               FlickerHelper.setFilcker(_proContent);
               preViewAtt(_currInfo.templateId,_loc3_,_currInfo.step);
            }
            else
            {
               FlickerHelper.clearFilcker(_proContent);
               _addLvTxt.visible = false;
               preViewAtt(_currInfo.templateId,_currInfo.level + 1,_currInfo.step);
            }
         }
      }
      
      private function preViewAtt(param1:int, param2:int, param3:int) : void
      {
         var _loc6_:StelesysNameAndValueTxt = null;
         var _loc10_:String = null;
         var _loc8_:int = 0;
         var _loc9_:StelaPropertyTemplateInfo = TempleteManager.instance.stelaPropertyTempCate.getTemplateById(param1,param2);
         var _loc7_:StelaStepTemplateInfo = TempleteManager.instance.stelaStepTempCate.getTemplateById(param1,param3);
         var _loc4_:StelaAttInfo = new StelaAttInfo();
         if(_loc9_)
         {
            _loc4_.Attack += _loc9_.Attack;
            _loc4_.Defence += _loc9_.Defence;
            _loc4_.MagicAttack += _loc9_.MagicAttack;
            _loc4_.MagicDefence += _loc9_.MagicDefence;
            _loc4_.Live += _loc9_.Live;
            _loc4_.ForceHit += _loc9_.ForceHit;
            _loc4_.Parry += _loc9_.Parry;
            _loc4_.Penetrate += _loc9_.Penetrate;
            _loc4_.ReduceResiAgainst += _loc9_.ReduceResiAgainst;
            _loc4_.ResiPenetrate += _loc9_.ResiPenetrate;
         }
         if(_loc7_)
         {
            _loc4_.Attack += _loc7_.Attack;
            _loc4_.Defence += _loc7_.Defence;
            _loc4_.MagicAttack += _loc7_.MagicAttack;
            _loc4_.MagicDefence += _loc7_.MagicDefence;
            _loc4_.Live += _loc7_.Live;
            _loc4_.ForceHit += _loc7_.ForceHit;
            _loc4_.Parry += _loc7_.Parry;
            _loc4_.Penetrate += _loc7_.Penetrate;
            _loc4_.ReduceResiAgainst += _loc7_.ReduceResiAgainst;
            _loc4_.ResiPenetrate += _loc7_.ResiPenetrate;
         }
         var _loc5_:Array = _loc4_.hasValueAtt;
         _loc8_ = 0;
         while(_loc8_ < 5)
         {
            _loc10_ = _loc5_[_loc8_];
            if(_loc10_ != null)
            {
               _loc6_ = _nextList[_loc8_];
               _loc6_.nameTxt = _loc10_;
               _loc6_.valueTxt = _loc4_[_loc10_];
            }
            _loc8_++;
         }
      }
      
      private function changeHandler(param1:NotificationEvent) : void
      {
         var _loc3_:StelesysInfo = param1.data as StelesysInfo;
         _currInfo = _loc3_;
         model.currIntensifyInfo = _currInfo;
         refreshProgress(_currInfo);
         refreshCurrAtt(_currInfo);
         refreshNextAtt(_currInfo);
         var _loc2_:String = "1|1|1|1|1|1,1|1|1|1|1|1";
         model.changeIntensifyStr(_loc2_);
         _menu.refreshSwitchMenuName(_loc2_);
         refreshView();
      }
      
      private function updateHandler(param1:NotificationEvent) : void
      {
         if(_currInfo == null)
         {
            return;
         }
         model.currIntensifyInfo = _currInfo;
         refreshProgress(_currInfo);
         refreshCurrAtt(_currInfo);
         refreshNextAtt(_currInfo);
         refreshView2();
      }
      
      private function refreshProgress(param1:StelesysInfo) : void
      {
         if(param1 == null)
         {
            return;
         }
         _lvTxt.text = "" + param1.level;
         _progress.progressValue(param1.exp,param1.currStrengthLvExp);
      }
      
      private function refreshCurrAtt(param1:StelesysInfo) : void
      {
         var _loc3_:StelesysNameAndValueTxt = null;
         var _loc6_:String = null;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return;
         }
         _intensifyItem.data = param1;
         var _loc5_:StelaAttInfo = param1.stelaAttInfo;
         var _loc2_:Array = _loc5_.hasValueAtt;
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc6_ = _loc2_[_loc4_];
            if(_loc6_ != null)
            {
               _loc3_ = _currList[_loc4_];
               _loc3_.nameTxt = _loc6_;
               _loc3_.valueTxt = _loc5_[_loc6_];
            }
            _loc4_++;
         }
      }
      
      private function refreshNextAtt(param1:StelesysInfo) : void
      {
         var _loc3_:StelesysNameAndValueTxt = null;
         var _loc6_:String = null;
         var _loc4_:int = 0;
         if(param1 == null || param1.stepTempInfo == null)
         {
            return;
         }
         var _loc5_:StelaAttInfo = param1.stelaAttInfo;
         if(param1.level == param1.stepTempInfo.StrengthLimit)
         {
            if(param1.nextStepTempInfo == null)
            {
               _needUpStepFlg.visible = false;
               _fullLevelFlg.visible = true;
               _intensifyBtn.visible = false;
               _oneKeyBtn.visible = false;
               _progress.showMax();
            }
            else
            {
               _needUpStepFlg.visible = true;
               _fullLevelFlg.visible = false;
               _intensifyBtn.visible = false;
               _oneKeyBtn.visible = false;
            }
         }
         else
         {
            _needUpStepFlg.visible = false;
            _fullLevelFlg.visible = false;
            _intensifyBtn.visible = true;
            _oneKeyBtn.visible = true;
            _loc5_ = param1.nextIntensifyAttInfo;
         }
         var _loc2_:Array = _loc5_.hasValueAtt;
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc6_ = _loc2_[_loc4_];
            if(_loc6_ != null)
            {
               _loc3_ = _nextList[_loc4_];
               _loc3_.nameTxt = _loc6_;
               _loc3_.valueTxt = _loc5_[_loc6_];
            }
            _loc4_++;
         }
      }
      
      private function get model() : StelesysModel
      {
         return SteleSysManager.Ins.model;
      }
   }
}

