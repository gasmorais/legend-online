package store.resolve
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.avenger.AvengerModel;
   import yishi.datas.templates.ResolveitemsortTempInfo;
   import yishi.manager.AvengerManager;
   import yishi.utils.MsgMan;
   
   public class AllResolvePopFrame extends Frame
   {
      
      private var _lvComBox:ComboBox;
      
      private var _typeComBox:ComboBox;
      
      private var _lv:int = 1;
      
      private var _type:int = 0;
      
      private var _backImg:ScaleFrameImage;
      
      private var _confirmBtn:BaseButton;
      
      private var _cancelBtn:BaseButton;
      
      private var _backImg1:ScaleFrameImage;
      
      private var _lvSelected:Boolean = false;
      
      private var _typeSelected:Boolean = false;
      
      private var _lvText:FilterFrameText;
      
      private var _typeText:FilterFrameText;
      
      private var _lvComBoxnum:int;
      
      public function AllResolvePopFrame()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _lvComBox = ComponentFactory.Instance.creatComponentByStylename("store.resolve.AllResolveLVComBox");
         _backImg = ComponentFactory.Instance.creatComponentByStylename("store.attribute.AppellComBoxBtnBack2");
         _lvComBox.button.addChild(_backImg);
         addToContent(_lvComBox);
         _typeComBox = ComponentFactory.Instance.creatComponentByStylename("store.resolve.AllResolveTypeComBox");
         _backImg1 = ComponentFactory.Instance.creatComponentByStylename("store.attribute.AppellComBoxBtnBack2");
         _typeComBox.button.addChild(_backImg1);
         addToContent(_typeComBox);
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert_cancelStyle_2");
         if(_confirmBtn)
         {
            addToContent(_confirmBtn);
         }
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert_confirmStyle_2");
         if(_cancelBtn)
         {
            addToContent(_cancelBtn);
         }
         _confirmBtn.x = 250;
         _cancelBtn.x = 70;
         _confirmBtn.y = _cancelBtn.y = 211;
         _lvText = ComponentFactory.Instance.creatComponentByStylename("store.AllResolvePopFrametext");
         _typeText = ComponentFactory.Instance.creatComponentByStylename("store.AllResolvePopFrametext2");
         addToContent(_lvText);
         addToContent(_typeText);
         _lvText.text = LanguageMgr.GetTranslation("AllResolvePopFrame.Avenger.desc1");
         _typeText.text = LanguageMgr.GetTranslation("AllResolvePopFrame.Avenger.desc2");
      }
      
      private function addEvent() : void
      {
         _lvComBox.button.addEventListener("click",__clickHandler);
         _lvComBox.listPanel.addEventListener("removedFromStage",__removedHandler);
         _lvComBox.listPanel.list.addEventListener("listItemClick",__honourChangeHandler);
         if(_confirmBtn)
         {
            _confirmBtn.addEventListener("click",__confirmHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.addEventListener("click",__cancelHandler);
         }
         addEventListener("response",__frameResponse);
         _typeComBox.button.addEventListener("click",__clickHandler1);
         _typeComBox.listPanel.addEventListener("removedFromStage",__removedHandler1);
         _typeComBox.listPanel.list.addEventListener("listItemClick",__honourChangeHandler1);
      }
      
      private function removeEvent() : void
      {
         _lvComBox.button.removeEventListener("click",__clickHandler);
         _lvComBox.listPanel.removeEventListener("removedFromStage",__removedHandler);
         _lvComBox.listPanel.list.removeEventListener("listItemClick",__honourChangeHandler);
         if(_confirmBtn)
         {
            _confirmBtn.removeEventListener("click",__confirmHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__cancelHandler);
         }
         removeEventListener("response",__frameResponse);
         _typeComBox.button.removeEventListener("click",__clickHandler1);
         _typeComBox.listPanel.removeEventListener("removedFromStage",__removedHandler1);
         _typeComBox.listPanel.list.removeEventListener("listItemClick",__honourChangeHandler1);
      }
      
      private function __honourChangeHandler(param1:ListItemEvent) : void
      {
         if(model.resolveLv != param1.cellValue.name)
         {
            _lv = int(param1.cellValue.id);
            model.resolveLv = param1.cellValue.name;
         }
      }
      
      private function __removedHandler(param1:Event) : void
      {
         if(_lvSelected)
         {
         }
         _lvSelected = false;
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         _lvSelected = !_lvSelected;
      }
      
      private function __honourChangeHandler1(param1:ListItemEvent) : void
      {
         var _loc2_:String = null;
         if(model.resolveType != param1.cellValue.name)
         {
            model.resolveType = param1.cellValue.name;
            _loc2_ = param1.cellValue.color;
            model.color = _loc2_.substring(2);
            _typeComBox.textField.textColor = int(param1.cellValue.color);
            _type = int(param1.cellValue.id);
            _lvComBoxnum = int(param1.cellValue.lv);
            refreshLvView();
         }
      }
      
      private function __removedHandler1(param1:Event) : void
      {
         if(_typeSelected)
         {
         }
         _typeSelected = false;
      }
      
      private function __clickHandler1(param1:MouseEvent) : void
      {
         _typeSelected = !_typeSelected;
      }
      
      private function refreshLvView() : void
      {
         var _loc3_:Object = null;
         var _loc2_:Object = null;
         var _loc4_:int = 0;
         var _loc1_:Array = new Array(_lvComBoxnum);
         _lvComBox.listPanel.vectorListModel.clear();
         _lv = 1;
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc2_ = {
               "id":_loc4_ + 1,
               "name":LanguageMgr.GetTranslation("AllResolvePopFrame.Avenger.name",_loc4_ + 1),
               "style":"store.style.HonerTxt"
            };
            if(_loc4_ == 0)
            {
               _loc3_ = _loc2_;
            }
            _lvComBox.listPanel.vectorListModel.append(_loc2_);
            _loc4_++;
         }
         _lvComBox.listPanel.list.defaultSelectItemByCellValue = _loc3_;
      }
      
      private function refreshView() : void
      {
         var _loc8_:String = null;
         var _loc2_:Object = null;
         var _loc3_:Object = null;
         var _loc1_:ResolveitemsortTempInfo = null;
         var _loc6_:int = 0;
         var _loc7_:Dictionary = AvengerManager.instance.resolveList;
         var _loc5_:Array = [];
         for each(var _loc4_:ResolveitemsortTempInfo in _loc7_)
         {
            if(_loc4_.Sontype == 670)
            {
               _loc5_.push(_loc4_);
            }
         }
         _typeComBox.listPanel.vectorListModel.clear();
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc1_ = _loc5_[_loc6_] as ResolveitemsortTempInfo;
            _loc8_ = "store.style.HonerTxt2" + (_loc6_ + 1);
            _loc3_ = {
               "id":_loc1_.Propety1,
               "name":_loc1_.PropetyName1,
               "color":_loc1_.Color,
               "lv":_loc1_.Propety2,
               "style":_loc8_
            };
            if(_loc6_ == 0)
            {
               _loc2_ = _loc3_;
               _lvComBoxnum = _loc2_.lv;
            }
            _typeComBox.listPanel.vectorListModel.append(_loc3_);
            if(_loc6_ == _loc5_.length - 1)
            {
               _loc3_ = {
                  "id":0,
                  "name":LanguageMgr.GetTranslation("AllResolvePopFrame.Avenger.name1"),
                  "color":"0xffffff",
                  "lv":_loc1_.Propety2,
                  "style":"store.style.HonerTxt"
               };
               _typeComBox.listPanel.vectorListModel.append(_loc3_,0);
               _typeComBox.listPanel.list.defaultSelectItemByCellValue = _loc3_;
            }
            _loc6_++;
         }
         _typeComBox.textField.textColor = 16777215;
         refreshLvView();
      }
      
      protected function __confirmHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function get model() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      private function __cancelHandler(param1:MouseEvent) : void
      {
         model.isAllResolve = true;
         MsgMan.notifyObserver("AVENGER_ALL_RESOLVE",[_lv,_type]);
         dispose();
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         this.titleText = LanguageMgr.GetTranslation("AllResolvePopFrame.Title.text");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_lvComBox);
         _lvComBox = null;
         ObjectUtils.disposeObject(_typeComBox);
         _typeComBox = null;
         ObjectUtils.disposeObject(_backImg);
         _backImg = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_backImg1);
         _backImg1 = null;
         ObjectUtils.disposeObject(_lvText);
         _lvText = null;
         ObjectUtils.disposeObject(_typeText);
         _typeText = null;
         super.dispose();
      }
   }
}

