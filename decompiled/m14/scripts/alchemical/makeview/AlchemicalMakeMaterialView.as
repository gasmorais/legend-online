package alchemical.makeview
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import mvc.module.alchemical.AlchemicalChildFormulaInfo;
   import mvc.module.alchemical.AlchemicalModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.AlchemicalManager;
   import yishi.utils.MoneyUtils;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class AlchemicalMakeMaterialView extends Component
   {
      
      private var needItem1:AlchemicalNeedMaterialItem;
      
      private var needItem2:AlchemicalNeedMaterialItem;
      
      private var needItem3:AlchemicalNeedMaterialItem;
      
      private var needItem4:AlchemicalNeedMaterialItem;
      
      private var catalystItem:BaseItemView;
      
      private var addCatalystBtn:SelectedButton;
      
      private var propItem1:BaseItemView;
      
      private var propItem2:BaseItemView;
      
      private var propItem3:BaseItemView;
      
      private var stepBtn1:SelectedTextButton;
      
      private var stepBtn2:SelectedTextButton;
      
      private var stepBtn3:SelectedTextButton;
      
      private var stepBtn4:SelectedTextButton;
      
      private var stepGroup:SelectedButtonGroup;
      
      private var catalystMc:MovieClip;
      
      private var makeBtn:BaseButton;
      
      private var STEP_STYLE:Array = ["AlchemicalMakeMaterialView.stepBtn1.select01","AlchemicalMakeMaterialView.stepBtn1.unselect01","AlchemicalMakeMaterialView.stepBtn1.select02","AlchemicalMakeMaterialView.stepBtn1.unselect02"];
      
      private var _preClickTime:Number;
      
      public function AlchemicalMakeMaterialView()
      {
         super();
         initView();
         addEvent();
         stepGroup.selectIndex = 0;
         refreshView();
      }
      
      private function initView() : void
      {
         needItem1 = ComponentFactory.Instance.creatCustomObject("AlchemicalMakeMaterialView.needItem1");
         needItem2 = ComponentFactory.Instance.creatCustomObject("AlchemicalMakeMaterialView.needItem2");
         needItem3 = ComponentFactory.Instance.creatCustomObject("AlchemicalMakeMaterialView.needItem3");
         needItem4 = ComponentFactory.Instance.creatCustomObject("AlchemicalMakeMaterialView.needItem4");
         catalystItem = ComponentFactory.Instance.creatCustomObject("AlchemicalMakeMaterialView.catalystItem");
         catalystMc = ComponentFactory.Instance.creatCustomObject("AlchemicalMakeMaterialView.catalystMc");
         addCatalystBtn = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeMaterialView.addCatalystBtn");
         propItem1 = ComponentFactory.Instance.creatCustomObject("AlchemicalMakeMaterialView.propItem1");
         propItem2 = ComponentFactory.Instance.creatCustomObject("AlchemicalMakeMaterialView.propItem2");
         propItem3 = ComponentFactory.Instance.creatCustomObject("AlchemicalMakeMaterialView.propItem3");
         stepBtn1 = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeMaterialView.stepBtn1");
         stepBtn2 = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeMaterialView.stepBtn2");
         stepBtn3 = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeMaterialView.stepBtn3");
         stepBtn4 = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeMaterialView.stepBtn4");
         makeBtn = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeMaterialView.makeBtn");
         addChild(needItem1);
         addChild(needItem2);
         addChild(needItem3);
         addChild(needItem4);
         addChild(catalystItem);
         addChild(addCatalystBtn);
         addChild(catalystMc);
         addChild(propItem1);
         addChild(propItem2);
         addChild(propItem3);
         addChild(stepBtn1);
         addChild(stepBtn2);
         addChild(stepBtn3);
         addChild(stepBtn4);
         addChild(makeBtn);
         stepGroup = new SelectedButtonGroup();
         stepGroup.addSelectItem(stepBtn1);
         stepGroup.addSelectItem(stepBtn2);
         stepGroup.addSelectItem(stepBtn3);
         stepGroup.addSelectItem(stepBtn4);
         catalystMc.mouseEnabled = catalystMc.mouseChildren = false;
         catalystMc.gotoAndStop(1);
         catalystMc.visible = false;
      }
      
      private function addEvent() : void
      {
         makeBtn.addEventListener("click",__makeClickHandler);
         stepGroup.addEventListener("change",__selectedChangHandler);
         addCatalystBtn.addEventListener("click",__addCatalystHandler);
         MsgMan.addObserver("SELECT_FORMULA_CHANGE",this,__updateSelectFormulaHandler);
         MsgMan.addObserver("ALCHEMICAL_FORMULA_UPDATE",this,__updateSelectFormulaHandler);
      }
      
      private function removeEvent() : void
      {
         if(makeBtn)
         {
            makeBtn.removeEventListener("click",__makeClickHandler);
         }
         if(stepGroup)
         {
            stepGroup.removeEventListener("change",__selectedChangHandler);
         }
         if(addCatalystBtn)
         {
            addCatalystBtn.removeEventListener("click",__addCatalystHandler);
         }
         MsgMan.removeObserver("SELECT_FORMULA_CHANGE",this,__updateSelectFormulaHandler);
         MsgMan.removeObserver("ALCHEMICAL_FORMULA_UPDATE",this,__updateSelectFormulaHandler);
      }
      
      private function __updateSelectFormulaHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __selectedChangHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         refreshView();
      }
      
      private function __makeClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!model.selectFormulaInfo)
         {
            return;
         }
         var _loc4_:Number = getTimer();
         if(_loc4_ - _preClickTime < 2000)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _preClickTime = _loc4_;
         var _loc3_:int = int(model.selectFormulaInfo.shareUid);
         var _loc2_:int = int(model.selectFormulaInfo.formulaId);
         var _loc5_:Boolean = Boolean(addCatalystBtn.selected);
         if(model.selectFormulaInfo.isCooperation)
         {
            if(model.selectFormulaInfo.isSelfJoin)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("AlchemicalMakeMaterialView.makeBtn.hasJoinAlert"));
               return;
            }
            AlchemicalManager.instance.sendAlchemicalSharedFormula(_loc3_,_loc5_,stepGroup.selectIndex + 1);
         }
         else if(model.selectFormulaInfo.isMutiFormula)
         {
            AlchemicalManager.instance.sendAlchemicalSelfFormula(_loc2_,_loc5_,stepGroup.selectIndex + 1);
         }
         else
         {
            AlchemicalManager.instance.sendAlchemicalSelfFormula(_loc2_,_loc5_);
         }
      }
      
      private function __addCatalystHandler(param1:MouseEvent) : void
      {
         resetCatalystState();
      }
      
      private function refreshView() : void
      {
         var _loc5_:int = 0;
         var _loc4_:Array = null;
         var _loc1_:Array = null;
         var _loc6_:GoodsInfo = null;
         var _loc9_:AlchemicalChildFormulaInfo = null;
         var _loc2_:GoodsInfo = null;
         var _loc3_:GoodsInfo = null;
         var _loc7_:int = 0;
         var _loc8_:Boolean = true;
         if(model.selectFormulaInfo)
         {
            stepGroup.selectIndex = model.selectFormulaInfo.stepCount < stepGroup.selectIndex + 1 ? 0 : stepGroup.selectIndex;
            _loc2_ = new GoodsInfo();
            _loc2_.templateId = 701000;
            catalystItem.data = _loc2_;
            addCatalystBtn.visible = true;
            _loc1_ = model.selectFormulaInfo.rewardItemArr;
            if(model.selectFormulaInfo.isMutiFormula)
            {
               _loc4_ = model.selectFormulaInfo.getNeedItemArrByIndex(stepGroup.selectIndex);
               _loc9_ = model.selectFormulaInfo.getChildFormulaInfoByIndex(stepGroup.selectIndex + 1);
            }
            else
            {
               _loc4_ = model.selectFormulaInfo.getNeedItemArrByIndex();
            }
            _loc5_ = 1;
            while(_loc5_ <= 4)
            {
               if(_loc5_ - 1 < _loc4_.length)
               {
                  _loc7_ = 0;
                  _loc7_ = int(_loc6_.count);
                  _loc6_ = model.getAlchemicalItemById(_loc4_[_loc5_ - 1][0]);
                  _loc6_ ? _loc7_ : (_loc7_);
                  this["needItem" + _loc5_].setData(_loc4_[_loc5_ - 1][0],_loc7_,_loc4_[_loc5_ - 1][1]);
                  if(_loc7_ < _loc4_[_loc5_ - 1][1])
                  {
                     _loc8_ = false;
                  }
               }
               else
               {
                  this["needItem" + _loc5_].setData(0,0,0);
               }
               if(model.selectFormulaInfo.isMutiFormula)
               {
                  this["stepBtn" + _loc5_].visible = true;
                  if(model.selectFormulaInfo.getChildFormulaInfoByIndex(_loc5_))
                  {
                     this["stepBtn" + _loc5_].text = LanguageMgr.GetTranslation("dayguide.ProjectItem.statusTxt");
                     this["stepBtn" + _loc5_].selectedStyle = STEP_STYLE[2];
                     this["stepBtn" + _loc5_].unSelectedStyle = STEP_STYLE[3];
                  }
                  else
                  {
                     this["stepBtn" + _loc5_].text = LanguageMgr.GetTranslation("AlchemicalMakeMaterialView.stepBtn.text",MoneyUtils.toCNUpper(_loc5_,true));
                     this["stepBtn" + _loc5_].selectedStyle = STEP_STYLE[0];
                     this["stepBtn" + _loc5_].unSelectedStyle = STEP_STYLE[1];
                  }
                  this["stepBtn" + _loc5_].visible = _loc5_ <= model.selectFormulaInfo.stepCount;
               }
               else
               {
                  this["stepBtn" + _loc5_].visible = false;
               }
               _loc5_++;
            }
            _loc5_ = 1;
            while(_loc5_ <= 3)
            {
               if(_loc5_ - 1 < _loc1_.length)
               {
                  _loc3_ = new GoodsInfo();
                  _loc3_.templateId = _loc1_[_loc5_ - 1][0];
                  _loc3_.count = _loc1_[_loc5_ - 1][1];
                  this["propItem" + _loc5_].data = _loc3_;
               }
               else
               {
                  this["propItem" + _loc5_].data = null;
               }
               _loc5_++;
            }
            if(model.selectFormulaInfo.isMutiFormula)
            {
               if(model.selectFormulaInfo.isCooperation)
               {
                  makeBtn.enable = _loc8_ && !_loc9_;
               }
               else
               {
                  makeBtn.enable = _loc8_ && Boolean(model.selectFormulaInfo.isOpen);
               }
               makeBtn.tipData = LanguageMgr.GetTranslation("AlchemicalMakeMaterialView.makeBtn.tipData1");
            }
            else
            {
               makeBtn.enable = _loc8_ && Boolean(model.selectFormulaInfo.isOpen);
               makeBtn.tipData = LanguageMgr.GetTranslation("AlchemicalMakeMaterialView.makeBtn.tipData2");
            }
         }
         else
         {
            makeBtn.enable = false;
            catalystItem.data = null;
            needItem1.setData(0,0,0);
            needItem2.setData(0,0,0);
            needItem3.setData(0,0,0);
            needItem4.setData(0,0,0);
            propItem1.data = propItem2.data = propItem3.data = null;
            stepBtn1.text = LanguageMgr.GetTranslation("dayguide.ProjectItem.statusTxt");
            _loc5_ = 1;
            while(_loc5_ <= 4)
            {
               this["stepBtn" + _loc5_].visible = false;
               this["stepBtn" + _loc5_].text = LanguageMgr.GetTranslation("AlchemicalMakeMaterialView.stepBtn.text",MoneyUtils.toCNUpper(_loc5_,true));
               _loc5_++;
            }
         }
         resetCatalystState();
      }
      
      private function resetCatalystState() : void
      {
         var _loc1_:GoodsInfo = null;
         var _loc2_:Boolean = false;
         if(!model.selectFormulaInfo)
         {
            addCatalystBtn.visible = false;
            addCatalystBtn.selected = false;
            return;
         }
         var _loc3_:AlchemicalChildFormulaInfo = model.selectFormulaInfo.getChildFormulaInfoByIndex(stepGroup.selectIndex + 1);
         if(model.selectFormulaInfo.isCooperation && _loc3_)
         {
            addCatalystBtn.selected = _loc3_.isAddCatalyst;
            catalystItem.filters = addCatalystBtn.selected ? [] : [UIFilter.getGrayFilter()];
         }
         else
         {
            _loc1_ = model.getAlchemicalItemById(701000);
            _loc2_ = _loc1_ && _loc1_.count > 0;
            if(!_loc2_)
            {
               addCatalystBtn.selected = false;
            }
            catalystItem.filters = addCatalystBtn.selected ? [] : [UIFilter.getGrayFilter()];
         }
         if(addCatalystBtn.selected)
         {
            catalystMc.gotoAndPlay(1);
            catalystMc.visible = true;
         }
         else
         {
            catalystMc.gotoAndStop(1);
            catalystMc.visible = false;
         }
      }
      
      private function get model() : AlchemicalModel
      {
         return AlchemicalManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(needItem1);
         needItem1 = null;
         ObjectUtils.disposeObject(needItem2);
         needItem2 = null;
         ObjectUtils.disposeObject(needItem3);
         needItem3 = null;
         ObjectUtils.disposeObject(needItem4);
         needItem4 = null;
         ObjectUtils.disposeObject(catalystItem);
         catalystItem = null;
         ObjectUtils.disposeObject(addCatalystBtn);
         addCatalystBtn = null;
         ObjectUtils.disposeObject(propItem1);
         propItem1 = null;
         ObjectUtils.disposeObject(propItem2);
         propItem2 = null;
         ObjectUtils.disposeObject(propItem3);
         propItem3 = null;
         ObjectUtils.disposeObject(stepBtn1);
         stepBtn1 = null;
         ObjectUtils.disposeObject(stepBtn2);
         stepBtn2 = null;
         ObjectUtils.disposeObject(stepBtn3);
         stepBtn3 = null;
         ObjectUtils.disposeObject(stepBtn4);
         stepBtn4 = null;
         ObjectUtils.disposeObject(makeBtn);
         makeBtn = null;
         ObjectUtils.disposeViolentMc(catalystMc);
         catalystMc = null;
         stepGroup = null;
         super.dispose();
      }
   }
}

