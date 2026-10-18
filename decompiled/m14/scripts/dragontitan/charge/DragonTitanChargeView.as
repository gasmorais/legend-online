package dragontitan.charge
{
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dragontitan.BasePanelComponent;
   import flash.display.Graphics;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.DragonTitanManager;
   import mvc.module.dragonTitan.DragonTitanChargeInfo;
   import utils.LogicUtils;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTitanChargeView extends BasePanelComponent
   {
      
      private var _cells:Array;
      
      private var _chargeBtn:IconButton;
      
      private var _currentTxt:FilterFrameText;
      
      private var _currentPackTxt:FilterFrameText;
      
      private var _image:Image;
      
      private var _countNameTxt:FilterFrameText;
      
      private var _inputTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _group:SelectedButtonGroup = new SelectedButtonGroup();
      
      private var _tipComponentRight:Component;
      
      private var _chargeInfo:DragonTitanChargeInfo;
      
      public function DragonTitanChargeView()
      {
         super();
         this.mouseEnabled = false;
         this.x = 189;
         this.y = 36;
      }
      
      override protected function initView() : void
      {
         var _loc3_:DragonTitanChargeCell = null;
         var _loc5_:int = 0;
         _tipComponentRight = getTipComponent(290);
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208060);
         _tipComponentRight.tipData = _loc1_.Description;
         _chargeBtn = addCreatComponentByStylename("dragontitan.chargeBtn");
         _countNameTxt = addCreatComponentByStylename("DragonTitanFrame.countNameTxt");
         _countNameTxt.text = LanguageMgr.GetTranslation("DragonTitanChargeView.initVieName");
         _currentTxt = addCreatComponentByStylename("DragonTitanFrame.currentItemTxt");
         _currentTxt.text = LanguageMgr.GetTranslation("DragonTitanChargeView.initVieCurrent",_loc1_.TemplateName);
         _currentPackTxt = addCreatComponentByStylename("DragonTitanFrame.currentItemCountTxt");
         _currentPackTxt.x -= 10;
         _image = addCreatComponentByStylename("mount.chargeCountBottom");
         _inputTxt = addCreatComponentByStylename("DragonTitan.chargeCountText");
         _inputTxt.text = "1";
         _descTxt = addCreatComponentByStylename("DragonTitan.chargeDesc");
         _descTxt.text = LanguageMgr.GetTranslation("DragonTitanChargeView.initViewDesc");
         var _loc6_:Array = chargeInfo.attList;
         var _loc2_:int = int(_loc6_.length);
         _cells = new Array(_loc2_);
         var _loc4_:int = 16;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = addCreatComponentByStylename("dragontitan.charge.DragonTitanChargeCell",[_loc6_[_loc5_]]);
            _loc3_.y = _loc4_;
            _loc4_ += _loc3_.height - 3;
            _group.addSelectItem(_loc3_);
            _cells[_loc5_] = _loc3_;
            _loc5_++;
         }
         _group.selectIndex = 0;
         __refreshView();
      }
      
      private function getTipComponent(param1:int) : Component
      {
         var _loc3_:Component = new Component();
         _loc3_.x = param1;
         _loc3_.y = 263;
         _loc3_.width = 130;
         _loc3_.height = 20;
         _loc3_.tipStyle = "faterotary.FateStoneIcon_Tip";
         var _loc2_:Graphics = _loc3_.graphics;
         _loc2_.beginFill(0,0.1);
         _loc2_.drawRect(0,0,130,20);
         _loc2_.endFill();
         addChild(_loc3_);
         return _loc3_;
      }
      
      override protected function initEvent() : void
      {
         addEvent(_chargeBtn,"click",onBtnHanlder);
         MsgMan.addObserver("DragonTitanEvent.TITAN_DATA",this,__refreshView);
         addEvent(_inputTxt,"change",LogicUtils.inputTxtChangeHandler);
         addEvent(GoodsManager.instance,"BAG_FULL",__onBagUpdate);
      }
      
      private function __onBagUpdate(param1:Object) : void
      {
         __refreshView();
      }
      
      override protected function removeEvent() : void
      {
         MsgMan.removeObserver("DragonTitanEvent.TITAN_DATA",this,__refreshView);
      }
      
      private function __refreshView(param1:String = null, param2:Object = null) : void
      {
         for each(var _loc3_:DragonTitanChargeCell in _cells)
         {
            _loc3_.update();
         }
         _currentPackTxt.text = GoodsManager.instance.getGoodsNumByTempId(208060).toString();
         _inputTxt.text = "1";
      }
      
      private function onBtnHanlder(param1:Event) : void
      {
         var _loc2_:String = null;
         if(!GoodsManager.instance.isBagGoodsEnough(208060,parseInt(_inputTxt.text)))
         {
            _loc2_ = LanguageMgr.GetTranslation("DragonTitanChargeView.itemNotEnough");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc3_:int = int(DragonTitanChargeCell(_group.getSelectedItem()).info.type);
         DragonTitanManager.instance.sendTitanRequest(6,_loc3_,parseInt(_inputTxt.text));
      }
      
      private function get chargeInfo() : DragonTitanChargeInfo
      {
         if(!_chargeInfo)
         {
            _chargeInfo = DragonTitanManager.instance.model.chargeInfo;
         }
         return _chargeInfo;
      }
      
      override public function dispose() : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         var _loc2_:Object = null;
         if(_cells)
         {
            _loc5_ = 0;
            while(_loc5_ < _cells.length)
            {
               ObjectUtils.disposeObject(_cells[_loc5_]);
               _loc5_++;
            }
            _cells.length = 0;
            _cells = null;
         }
         var _loc1_:Array = ["_chargeBtn","_currentTxt","_currentPackTxt","_image","_inputTxt","_group","_tipComponentRight"];
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc4_ = Boolean(this.hasOwnProperty(_loc1_[_loc3_]));
            _loc2_ = this[_loc1_[_loc3_]];
            ObjectUtils.disposeObject(_loc2_);
            this[_loc1_[_loc3_]] = null;
            _loc3_++;
         }
         super.dispose();
         if(_chargeBtn)
         {
            ObjectUtils.disposeObject(_chargeBtn);
         }
         _chargeBtn = null;
         if(_currentTxt)
         {
            ObjectUtils.disposeObject(_currentTxt);
         }
         _currentTxt = null;
         if(_currentPackTxt)
         {
            ObjectUtils.disposeObject(_currentPackTxt);
         }
         _currentPackTxt = null;
         if(_image)
         {
            ObjectUtils.disposeObject(_image);
         }
         _image = null;
         if(_inputTxt)
         {
            ObjectUtils.disposeObject(_inputTxt);
         }
         _inputTxt = null;
         if(_group)
         {
            ObjectUtils.disposeObject(_group);
         }
         _group = null;
         if(_tipComponentRight)
         {
            ObjectUtils.disposeObject(_tipComponentRight);
         }
         _tipComponentRight = null;
      }
      
      private function disposeCell(param1:DragonTitanChargeCell, param2:Object, param3:Object) : void
      {
         param1.dispose();
      }
   }
}

