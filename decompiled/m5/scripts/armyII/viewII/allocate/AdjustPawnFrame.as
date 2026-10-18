package armyII.viewII.allocate
{
   import armyII.viewII.lineUp.LineUpFormationItem;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.Silder;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.UserArmy;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   
   public class AdjustPawnFrame extends Frame
   {
      
      private var _silder:Silder;
      
      private var _acceptbutton:SelectedCheckButton;
      
      private var _cancelbutton:SelectedCheckButton;
      
      private var _maxButton:BaseButton;
      
      private var _background:ScaleBitmapImage;
      
      private var _number:FilterFrameText;
      
      private var _currentNumber:FilterFrameText;
      
      private var _maxNumber:FilterFrameText;
      
      private var _target:Object;
      
      private var _self:Object;
      
      private var _count:int;
      
      public function AdjustPawnFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _background = ComponentFactory.Instance.creatComponentByStylename("army.AdjustBack");
         _silder = ComponentFactory.Instance.creatComponentByStylename("army.AdjustSilder");
         _maxButton = ComponentFactory.Instance.creatComponentByStylename("army.AdjustMaxButton");
         _acceptbutton = ComponentFactory.Instance.creatComponentByStylename("army.AdjustAccept");
         _acceptbutton.text = LanguageMgr.GetTranslation("public.confirm");
         _cancelbutton = ComponentFactory.Instance.creatComponentByStylename("army.AdjustCancel");
         _cancelbutton.text = LanguageMgr.GetTranslation("public.cancel");
         _number = ComponentFactory.Instance.creatComponentByStylename("army.AdjustNumber");
         _number.text = LanguageMgr.GetTranslation("armyII.viewII.allocate.number");
         _currentNumber = ComponentFactory.Instance.creatComponentByStylename("army.AdjustCurrentNumber");
         _maxNumber = ComponentFactory.Instance.creatComponentByStylename("army.AdjustMaxNumber");
         _maxNumber.x = _currentNumber.x + _currentNumber.textWidth;
         addToContent(_background);
         addToContent(_silder);
         addToContent(_maxButton);
         addToContent(_acceptbutton);
         addToContent(_cancelbutton);
         addToContent(_number);
         addToContent(_currentNumber);
         addToContent(_maxNumber);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeObject(_background);
         _background = null;
         ObjectUtils.disposeObject(_silder);
         _silder = null;
         ObjectUtils.disposeObject(_maxButton);
         _maxButton = null;
         ObjectUtils.disposeObject(_acceptbutton);
         _acceptbutton = null;
         ObjectUtils.disposeObject(_cancelbutton);
         _cancelbutton = null;
         ObjectUtils.disposeObject(_number);
         _number = null;
         ObjectUtils.disposeObject(_currentNumber);
         _currentNumber = null;
         ObjectUtils.disposeObject(_maxNumber);
         _maxNumber = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _silder.addEventListener("stateChange",__change);
         _maxButton.addEventListener("click",__max);
         _acceptbutton.addEventListener("click",__accept);
         _cancelbutton.addEventListener("click",__cancel);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _silder.removeEventListener("stateChange",__change);
         _maxButton.removeEventListener("click",__max);
         _acceptbutton.removeEventListener("click",__accept);
         _cancelbutton.removeEventListener("click",__cancel);
      }
      
      private function __change(param1:InteractiveEvent) : void
      {
         _currentNumber.text = String(Math.round(_silder.value));
         _maxNumber.x = _currentNumber.x + _currentNumber.textWidth;
      }
      
      private function __max(param1:MouseEvent) : void
      {
         _silder.value = _count;
         _currentNumber.text = String(_count);
         _maxNumber.x = _currentNumber.x + _currentNumber.textWidth;
      }
      
      private function __accept(param1:MouseEvent) : void
      {
         var _loc2_:int = int(_currentNumber.text);
         if(_target is SoldierDragCell || _target is LineUpFormationItem)
         {
            if(_target.isLock)
            {
               return;
            }
            if(_target.pawn)
            {
               if(_target.pawn.templateId == _self.pawn.templateId)
               {
                  joinPawn(_self,_target,_loc2_);
               }
               else
               {
                  swapPawn(_self,_target,_loc2_);
               }
            }
            else
            {
               addPawnToTarget(_self,_target,_loc2_);
            }
         }
         __cancel(null);
      }
      
      public function swapPawn(param1:Object, param2:Object, param3:int) : void
      {
         var _loc4_:int = int(param2.pawn.templateId);
         var _loc5_:int = int(param2.pawn.ownPawns);
         userArmy.addNewPawnByIndex(param2.site,param1.pawn,param3);
         param1.pawn.ownPawns -= param3;
         param1.pawn.commit();
         ArmyManager.instance.addPawnCountById(_loc4_,_loc5_);
         control.sendMovePawnInfo();
      }
      
      public function joinPawn(param1:Object, param2:Object, param3:int) : void
      {
         userArmy.addArmyPawnCountByIndex(param2.site,param3);
         param1.pawn.ownPawns -= param3;
         param1.pawn.commit();
         control.sendMovePawnInfo();
      }
      
      public function addPawnToTarget(param1:Object, param2:Object, param3:int) : void
      {
         userArmy.addNewPawnByIndex(param2.site,param1.pawn,param3);
         param1.pawn.ownPawns -= param3;
         param1.pawn.commit();
         control.sendMovePawnInfo();
      }
      
      private function __cancel(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function refreshView() : void
      {
         _silder.maximum = _count;
         _silder.minimum = 1;
         _currentNumber.text = String(_count);
         _maxNumber.text = " / " + _count;
         _maxNumber.x = _currentNumber.x + _currentNumber.textWidth;
         _silder.value = _count;
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function get userArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      public function set target(param1:Object) : void
      {
         _target = param1;
      }
      
      public function set self(param1:Object) : void
      {
         _self = param1;
      }
      
      public function set count(param1:int) : void
      {
         _count = param1;
         refreshView();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,false,2);
         KeyBoardRegister.instance.keyEnable = false;
         titleText = LanguageMgr.GetTranslation("armyII.viewII.allocate.title");
         FrameControllerManager.instance.armyController.isAdjustPawn = true;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninit();
         super.dispose();
         FrameControllerManager.instance.armyController.isAdjustPawn = false;
      }
   }
}

