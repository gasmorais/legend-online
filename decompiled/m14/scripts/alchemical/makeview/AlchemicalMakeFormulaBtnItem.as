package alchemical.makeview
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import mvc.module.alchemical.AlchemicalModel;
   import utils.LogicUtils;
   import yishi.manager.AlchemicalManager;
   import yishi.utils.MsgMan;
   
   public class AlchemicalMakeFormulaBtnItem extends Component implements ISelectable
   {
      
      private var titleBtn:IconButton;
      
      private var arrowImage:ScaleFrameImage;
      
      private var formulaVbox:VBox;
      
      private var formulaList:Vector.<AlchemicalMakeNoteFormulaItem>;
      
      private var _isSelected:Boolean;
      
      private var _selectState:Boolean;
      
      private var _btnType:int;
      
      public function AlchemicalMakeFormulaBtnItem(param1:int)
      {
         super();
         _btnType = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleBtn = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeFormulaBtnItem.titleBtn" + btnType);
         arrowImage = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeFormulaBtnItem.arrowImage");
         formulaVbox = ComponentFactory.Instance.creatComponentByStylename("AlchemicalMakeFormulaBtnItem.formulaVbox");
         addChild(titleBtn);
         titleBtn.addChild(arrowImage);
         addChild(formulaVbox);
      }
      
      private function addEvent() : void
      {
         titleBtn.addEventListener("click",__formulaBtnItemSelectHandler);
         MsgMan.addObserver("SELECT_FORMULA_CHANGE",this,__updateSelectChange);
      }
      
      private function removeEvent() : void
      {
         if(titleBtn)
         {
            titleBtn.removeEventListener("click",__formulaBtnItemSelectHandler);
         }
         MsgMan.removeObserver("SELECT_FORMULA_CHANGE",this,__updateSelectChange);
      }
      
      private function __updateSelectChange(param1:String, param2:Object) : void
      {
         if(selected)
         {
            for each(var _loc3_:AlchemicalMakeNoteFormulaItem in formulaList)
            {
               if(model.selectFormulaInfo && _loc3_.tempInfo && _loc3_.tempInfo.Id == model.selectFormulaInfo.formulaId)
               {
                  _loc3_.selected = true;
               }
               else
               {
                  _loc3_.selected = false;
               }
            }
         }
      }
      
      private function __formulaBtnItemSelectHandler(param1:MouseEvent) : void
      {
         if(selected)
         {
            selectState = !selectState;
            MsgMan.notifyObserver("FORMULA_LISTVIEW_UPDATE");
         }
         if(model.selectFormulaType != btnType)
         {
            model.selectFormulaInfo = null;
         }
         model.selectFormulaType = btnType;
      }
      
      private function setformulaVbox() : void
      {
         var _loc3_:Array = null;
         var _loc2_:int = 0;
         var _loc1_:AlchemicalMakeNoteFormulaItem = null;
         formulaVbox.removeAllChild();
         LogicUtils.disposeDisplayCollection(formulaList);
         formulaList = new Vector.<AlchemicalMakeNoteFormulaItem>();
         if(selected && selectState)
         {
            _loc3_ = model.getFormulaTempListByType(btnType,model.modelType);
            _loc2_ = 0;
            while(_loc2_ < _loc3_.length)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("AlchemicalMakeFormulaBtnItem.FormulaBtnItem");
               _loc1_.tempInfo = _loc2_ < _loc3_.length ? _loc3_[_loc2_] : null;
               formulaVbox.addChild(_loc1_);
               formulaList.push(_loc1_);
               if(model.selectFormulaInfo)
               {
                  if(_loc1_.tempInfo && _loc1_.tempInfo.Id == model.selectFormulaInfo.formulaId)
                  {
                     _loc1_.selected = true;
                  }
                  else
                  {
                     _loc1_.selected = false;
                  }
               }
               else if(_loc2_ == 0)
               {
                  _loc1_.selected = true;
               }
               else
               {
                  _loc1_.selected = false;
               }
               _loc2_++;
            }
         }
      }
      
      public function get btnType() : int
      {
         return _btnType;
      }
      
      public function get selected() : Boolean
      {
         return _isSelected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _isSelected = param1;
      }
      
      public function get selectState() : Boolean
      {
         return _selectState;
      }
      
      public function set selectState(param1:Boolean) : void
      {
         _selectState = param1;
         if(selected && _selectState)
         {
            arrowImage.setFrame(2);
         }
         else
         {
            arrowImage.setFrame(1);
         }
         setformulaVbox();
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      private function get model() : AlchemicalModel
      {
         return AlchemicalManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(titleBtn);
         titleBtn = null;
         ObjectUtils.disposeObject(arrowImage);
         arrowImage = null;
         ObjectUtils.disposeObject(formulaVbox);
         formulaVbox = null;
         LogicUtils.disposeDisplayCollection(formulaList);
         formulaList = null;
         super.dispose();
      }
   }
}

