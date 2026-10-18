package stelesys.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SteleSysManager;
   import mvc.module.stele.StelesysInfo;
   import mvc.module.stele.StelesysModel;
   import mvc.module.stele.StelesysRefineInfo;
   import stelesys.item.StelaReineBoxItem;
   import stelesys.item.StelesysNewRefineItem;
   import stelesys.item.StelesysRefineItem;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.StelaStepTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.StringHelper;
   import yishi.view.tips.MessageTipManager;
   
   public class SteleSysRefineView extends Component
   {
      
      private const LOCK_ID:int = 7110002;
      
      private var _bg:MutipleImage;
      
      private var _currItem:StelaReineBoxItem;
      
      private var _nameTxt:FilterFrameText;
      
      private var _refineBtn:IconButton;
      
      private var _mc:MovieClip;
      
      private var _currBox:VBox;
      
      private var _currList:Array = [];
      
      private var _newBox:VBox;
      
      private var _newList:Array = [];
      
      private var _newBtn:BaseButton;
      
      private var _currInfo:StelesysInfo;
      
      private var _lockNumTxt:FilterFrameText;
      
      private var _metrialTxt:FilterFrameText;
      
      private var _metrialIcon:Image;
      
      private var _lockGoodNum:int;
      
      private var _hasMetrialNum:int;
      
      private var _rowBit:Image;
      
      public function SteleSysRefineView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc4_:StelesysRefineItem = null;
         var _loc1_:StelesysNewRefineItem = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.refineBg");
         _refineBtn = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.refineDoBtn");
         _currItem = ComponentFactory.Instance.creatCustomObject("stelesys.refine.currItem");
         _mc = ComponentFactory.Instance.creatCustomObject("asset.stelesys.refineItemMc");
         _currBox = ComponentFactory.Instance.creatCustomObject("ui.stelesys.refineCurrBox");
         _newBox = ComponentFactory.Instance.creatCustomObject("ui.stelesys.refineNewBox");
         _newBtn = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.refineNewBtn");
         _lockNumTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.refineMLockTxt");
         _metrialTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.refineMetrialTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.refineStelaNameTxt");
         _metrialIcon = ComponentFactory.Instance.creatComponentByStylename("ui.asset.stelesys.refineIcon");
         _rowBit = ComponentFactory.Instance.creatComponentByStylename("ui.stela.refine.rowBit");
         _mc.blendMode = "add";
         refreshLockGoods();
         addChild(_bg);
         addChild(_refineBtn);
         addChild(_currItem);
         addChild(_mc);
         addChild(_currBox);
         addChild(_newBox);
         addChild(_newBtn);
         addChild(_lockNumTxt);
         addChild(_metrialTxt);
         addChild(_nameTxt);
         addChild(_metrialIcon);
         addChild(_rowBit);
         _newBtn.enable = false;
         _refineBtn.enable = false;
         _metrialTxt.text = "0/0";
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(7110001);
         if(_loc2_)
         {
            _metrialIcon.tipData = _loc2_.Description;
         }
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 5)
         {
            _loc4_ = new StelesysRefineItem();
            _loc1_ = new StelesysNewRefineItem();
            _currList[_loc3_] = _loc4_;
            _newList[_loc3_] = _loc1_;
            _loc3_++;
         }
         _mc.gotoAndStop(29);
      }
      
      private function refreshLockGoods() : void
      {
         _lockGoodNum = GoodsManager.instance.getGoodsNumByTempId(7110002);
         _lockNumTxt.text = "" + _lockGoodNum;
      }
      
      private function freshMetrialNum() : void
      {
         var _loc1_:StelaStepTemplateInfo = null;
         if(_currInfo)
         {
            _loc1_ = _currInfo.stepTempInfo;
            if(_loc1_)
            {
               _hasMetrialNum = GoodsManager.instance.getGoodsNumByTempId(_loc1_.BaptizeCostItem);
               _metrialTxt.text = _hasMetrialNum + "/" + _loc1_.BaptizeCostNum;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_refineBtn);
         _refineBtn = null;
         ObjectUtils.disposeObject(_currItem);
         _currItem = null;
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         ObjectUtils.disposeObject(_currBox);
         _currBox = null;
         ObjectUtils.disposeObject(_newBox);
         _newBox = null;
         ObjectUtils.disposeObject(_newBtn);
         _newBtn = null;
         ObjectUtils.disposeObject(_lockNumTxt);
         _lockNumTxt = null;
         ObjectUtils.disposeObject(_metrialTxt);
         _metrialTxt = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_metrialIcon);
         _metrialIcon = null;
         ObjectUtils.disposeObject(_rowBit);
         _rowBit = null;
         _currList = null;
         _newList = null;
         _currInfo = null;
         super.dispose();
      }
      
      private function initEvent() : void
      {
         _refineBtn.addEventListener("click",refineClickHandler);
         _newBtn.addEventListener("click",_newBtnClickHandler);
         NotificationManager.instance.addEventListener("STELE_SYS_CHOOSE",changeHandler);
         NotificationManager.instance.addEventListener("STELE_SYS_REFINE",upDataHandler);
      }
      
      private function removeEvent() : void
      {
         _refineBtn.removeEventListener("click",refineClickHandler);
         _newBtn.removeEventListener("click",_newBtnClickHandler);
         NotificationManager.instance.removeEventListener("STELE_SYS_CHOOSE",changeHandler);
         NotificationManager.instance.removeEventListener("STELE_SYS_REFINE",upDataHandler);
      }
      
      private function upDataHandler(param1:NotificationEvent) : void
      {
         var _loc2_:Array = param1.data as Array;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:int = int(_loc2_[0]);
         var _loc4_:StelesysRefineInfo = _loc2_[1];
         switch(_loc3_ - 4)
         {
            case 0:
            case 1:
               _newBox.visible = true;
               _newBtn.enable = true;
               freshNewAtt(_loc4_);
               break;
            case 2:
               _newBox.visible = false;
               _newBtn.enable = false;
               refreshCurrAtt();
         }
      }
      
      private function refreshCurrAtt(param1:Boolean = false) : void
      {
         var _loc3_:StelesysRefineItem = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         _currBox.removeAllChild();
         _currBox.beginChanges();
         var _loc5_:Array = [_currInfo.skill1,_currInfo.skill2,_currInfo.skill3,_currInfo.skill4,_currInfo.skill5];
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc2_ = int(_loc5_[_loc4_]);
            _loc3_ = _currList[_loc4_];
            if(_loc2_ > 0)
            {
               _currBox.addChild(_loc3_);
               _loc3_.skillId = _loc2_;
               if(param1)
               {
                  _loc3_.resetLock();
               }
            }
            else if(param1)
            {
               _loc3_.resetLock();
            }
            _loc4_++;
         }
         _currBox.commitChanges();
         _newBox.removeAllChild();
      }
      
      private function freshNewAtt(param1:StelesysRefineInfo) : void
      {
         var _loc3_:StelesysNewRefineItem = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(_currInfo == null || _currInfo.id != param1.stelaId)
         {
            return;
         }
         _newBox.removeAllChild();
         _newBox.beginChanges();
         var _loc5_:Array = param1.skills;
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc2_ = int(_loc5_[_loc4_]);
            _loc3_ = _newList[_loc4_];
            if(_loc2_ > 0)
            {
               _newBox.addChild(_loc3_);
               _loc3_.skillId = _loc2_;
            }
            _loc4_++;
         }
         _newBox.commitChanges();
         refreshLockGoods();
         freshMetrialNum();
      }
      
      private function changeHandler(param1:NotificationEvent) : void
      {
         var _loc4_:StelesysInfo;
         _currInfo = _loc4_ = param1.data as StelesysInfo;
         _refineBtn.enable = true;
         _currItem.data = _currInfo;
         var _loc3_:String = _currInfo.tempInfo.TemplateName + " +" + _currInfo.step;
         var _loc2_:String = StringHelper.format("<font color={0}>{1}</font>",GoodsHelp.getGoodColorString(_currInfo.stepColor > 0 ? _currInfo.stepColor : 1),_loc3_);
         _nameTxt.htmlText = _loc2_;
         freshMetrialNum();
         refreshCurrAtt(true);
         SteleSysManager.Ins.sendGetRefine(_currInfo.id);
      }
      
      private function refineClickHandler(param1:MouseEvent) : void
      {
         var _loc3_:StelesysRefineItem = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:Array = [0,0,0,0,0];
         var _loc4_:int = int(_currBox.numChildren);
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            if(_loc6_ < _loc4_)
            {
               _loc3_ = _currBox.getChildAt(_loc6_) as StelesysRefineItem;
               if(_loc3_ && _loc3_.isLock)
               {
                  _loc2_[_loc6_] = 1;
                  _loc5_++;
               }
               else
               {
                  _loc2_[_loc6_] = 0;
               }
            }
            else
            {
               _loc2_[_loc6_] = 0;
            }
            _loc6_++;
         }
         if(_loc5_ == _currInfo.stepTempInfo.BaptizeLimit)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("stela.refine.allLock"));
            return;
         }
         var _loc7_:String = _loc2_.join(",");
         SteleSysManager.Ins.sendRefine(_currInfo.id,_loc7_);
      }
      
      private function _newBtnClickHandler(param1:MouseEvent) : void
      {
         _newBtn.enable = false;
         SteleSysManager.Ins.sendReplaceRefine(_currInfo.id);
         _mc.gotoAndPlay(1);
      }
      
      private function get model() : StelesysModel
      {
         return SteleSysManager.Ins.model;
      }
   }
}

