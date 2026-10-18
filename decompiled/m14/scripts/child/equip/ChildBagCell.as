package child.equip
{
   import child.ChildFrame;
   import child.ChildNursingSpiritFrame;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Shape;
   import flash.events.MouseEvent;
   import managers.ChildManager;
   import pet.advanced.equipbag.PetBagCell;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.MediatorMananger;
   
   public class ChildBagCell extends PetBagCell
   {
      
      public static const P_activeStyle:String = "activeStyle";
      
      public static const P_strengthenGrade:String = "strengthenGrade";
      
      public static const P_intensifyButtonStyle:String = "intensifyButton";
      
      public static const P_composeButtonStyle:String = "composeButton";
      
      private var _canDrop:Boolean;
      
      public var celltType:String;
      
      public var _intensifyStyle:String;
      
      private var _strengthenGrade:String;
      
      protected var _intensifyButton:IconButton;
      
      public var _composeStyle:String;
      
      protected var _composeButton:IconButton;
      
      protected var _strengthenGradeText:FilterFrameText;
      
      protected var _activeStyle:String;
      
      protected var _activeBack:MovieImage;
      
      protected var _canClick:Boolean;
      
      protected var _shape:Shape;
      
      public function ChildBagCell(param1:Boolean = true, param2:Boolean = true)
      {
         _canDrop = param1;
         _canClick = param2;
         super();
      }
      
      override protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [];
         if(_canDrop)
         {
            _loc1_ = [ChildBagCellClickMediator,ChildBagCellDropMediator];
         }
         else if(_canClick)
         {
            _loc1_ = [ChildBagCellClickMediator];
         }
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"child.equip.ChildBagCell");
      }
      
      public function set activeStyle(param1:String) : void
      {
         _activeStyle = param1;
         onPropertiesChanged("activeStyle");
      }
      
      public function set intensifyStyle(param1:String) : void
      {
         _intensifyStyle = param1;
         onPropertiesChanged("intensifyButton");
      }
      
      public function get intensifyStyle() : String
      {
         return _intensifyStyle;
      }
      
      public function set composeStyle(param1:String) : void
      {
         _composeStyle = param1;
         onPropertiesChanged("composeButton");
      }
      
      public function get composeStyle() : String
      {
         return _composeStyle;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["activeStyle"])
         {
            _activeBack = ComponentFactory.Instance.creatComponentByStylename(_activeStyle);
            _activeBack.visible = false;
            _activeBack.movie.gotoAndStop(1);
            _activeBack.mouseChildren = false;
            _activeBack.mouseEnabled = false;
         }
         if(_changedPropeties["intensifyButton"])
         {
            _intensifyButton = ComponentFactory.Instance.creatComponentByStylename(_intensifyStyle);
            if(_intensifyButton)
            {
               _intensifyButton.addEventListener("click",__intensifyButtonHandler);
            }
            _intensifyButton.visible = false;
         }
         if(_changedPropeties["composeButton"])
         {
            _composeButton = ComponentFactory.Instance.creatComponentByStylename(_composeStyle);
            if(_composeButton)
            {
               _composeButton.addEventListener("click",__composeButtonHandler);
            }
            _composeButton.visible = false;
         }
         if(_changedPropeties["strengthenGrade"])
         {
            _strengthenGradeText = ComponentFactory.Instance.creatComponentByStylename(_strengthenGrade);
            _strengthenGradeText.visible = false;
         }
         createShape();
         removeShape();
      }
      
      protected function __composeButtonHandler(param1:MouseEvent) : void
      {
         changeToEquipView();
      }
      
      protected function __intensifyButtonHandler(param1:MouseEvent) : void
      {
         changeToEquipView();
      }
      
      private function changeToEquipView() : void
      {
         var _loc1_:Object = {
            "index":0,
            "bagType":data.bagType,
            "pos":data.pos
         };
         if(ChildManager.instance.frameShowType == 1)
         {
            ChildFrame(parent.parent.parent.parent.parent.parent).changeToTab(1,_loc1_);
         }
         else if(ChildManager.instance.frameShowType == 2)
         {
            ChildNursingSpiritFrame(parent.parent.parent.parent.parent.parent).changeToTab(4,_loc1_);
         }
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         super.data = param1;
         removeShape();
         if(_petEquipIcon)
         {
            _petEquipIcon.visible = false;
         }
         if(param1 && param1.templateInfo.MasterType == 6 && param1.strengthenGrade >= param1.templateInfo.StrengthenMax)
         {
            if(_strengthenIcon)
            {
               _strengthenIcon.visible = true;
            }
         }
         else if(_strengthenIcon)
         {
            _strengthenIcon.visible = false;
         }
      }
      
      override protected function addChildren() : void
      {
         if(_back)
         {
            addChild(_back);
         }
         if(_typeText)
         {
            addChild(_typeText);
         }
         if(_icon)
         {
            addChild(_icon);
         }
         if(_shape)
         {
            addChild(_shape);
         }
         if(_profile)
         {
            addChild(_profile);
         }
         if(_itemText)
         {
            addChild(_itemText);
         }
         if(_strengthenIcon)
         {
            addChild(_strengthenIcon);
         }
         if(_fashionImage)
         {
            addChild(_fashionImage);
         }
         if(_fashionText)
         {
            addChild(_fashionText);
         }
         if(_petEquipIcon)
         {
            addChild(_petEquipIcon);
         }
         if(_activeBack)
         {
            addChild(_activeBack);
         }
      }
      
      public function showCanIntensify(param1:Boolean, param2:Boolean = false) : void
      {
         _intensifyButton.visible = param1;
         if(param2)
         {
            _intensifyButton.x = -55;
         }
         if(_intensifyButton && param1)
         {
            addChild(_intensifyButton);
         }
      }
      
      public function showCanCompose(param1:Boolean, param2:Boolean = false) : void
      {
         _composeButton.visible = param1;
         if(param2)
         {
            _composeButton.x = -55;
         }
         if(_composeButton && param1)
         {
            addChild(_composeButton);
         }
      }
      
      public function setNormal() : void
      {
         if(_activeBack)
         {
            _activeBack.visible = false;
            _activeBack.movie.stop();
         }
      }
      
      public function createShape() : void
      {
         if(!_shape)
         {
            _shape = new Shape();
         }
         _shape.graphics.beginFill(16711680);
         _shape.graphics.drawRect(0,0,45,40);
         _shape.graphics.endFill();
         _shape.x = 0;
         _shape.y = 4;
         _shape.blendMode = "multiply";
         _shape.visible = true;
      }
      
      public function removeShape() : void
      {
         if(_shape)
         {
            _shape.visible = false;
         }
      }
      
      public function showStrengthenGrade() : void
      {
         if(_petEquipIcon)
         {
            _petEquipIcon.visible = true;
         }
         if(_strengthenGradeText)
         {
            _strengthenGradeText.visible = true;
            addChild(_strengthenGradeText);
            _strengthenGradeText.text = "+" + data.strengthenGrade;
         }
      }
      
      public function setFocus() : void
      {
         if(_activeBack)
         {
            _activeBack.visible = true;
            _activeBack.movie.play();
         }
      }
      
      override public function get width() : Number
      {
         return 60;
      }
      
      override public function get height() : Number
      {
         return 60;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_activeBack)
         {
            ObjectUtils.disposeObject(_activeBack);
         }
         _activeBack = null;
         if(_intensifyButton)
         {
            ObjectUtils.disposeObject(_intensifyButton);
         }
         _intensifyButton = null;
         if(_composeButton)
         {
            ObjectUtils.disposeObject(_composeButton);
         }
         _composeButton = null;
         if(_intensifyButton)
         {
            _intensifyButton.removeEventListener("click",__intensifyButtonHandler);
         }
         if(_composeButton)
         {
            _composeButton.removeEventListener("click",__composeButtonHandler);
         }
         if(_strengthenGradeText)
         {
            ObjectUtils.disposeObject(_strengthenGradeText);
         }
         _strengthenGradeText = null;
         if(_typeText)
         {
            ObjectUtils.disposeObject(_typeText);
         }
         _typeText = null;
      }
      
      public function get strengthenGrade() : String
      {
         return _strengthenGrade;
      }
      
      public function set strengthenGrade(param1:String) : void
      {
         _strengthenGrade = param1;
         onPropertiesChanged("strengthenGrade");
      }
   }
}

