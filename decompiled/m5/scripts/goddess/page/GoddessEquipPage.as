package goddess.page
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import goddess.view.GoddessBaseEquipView;
   import goddess.view.GoddessEquipStepView;
   import goddess.view.GoddessEquipStrengthView;
   import goddess.view.GoddessEquipView;
   import managers.GodDessManager;
   import mvc.module.goddess.GodDessModel;
   import mvc.module.goddess.GoddessEquipInfo;
   import mvc.module.goddess.GoddessInfo;
   import yishi.utils.MsgMan;
   import yishi.view.base.TabPageUtil;
   
   public class GoddessEquipPage extends Component
   {
      
      private var _eqBG:Bitmap;
      
      private var _strengthBtn:SelectedIconButton;
      
      private var _stepBtn:SelectedIconButton;
      
      private var _tabPageUtil:TabPageUtil;
      
      private var _equipView:GoddessEquipView;
      
      private var _data:GoddessInfo;
      
      public function GoddessEquipPage()
      {
         super();
         initView();
         initEvent();
         chooseHandler(null,model.selectInfo);
      }
      
      private function initView() : void
      {
         _eqBG = ComponentFactory.Instance.creatBitmap("asset.goddess.equipBg");
         _strengthBtn = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eq.strengthTabSbtn");
         _stepBtn = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eq.stepTabSbtn");
         _equipView = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.view.GoddessEquipView");
         addChild(_eqBG);
         addChild(_strengthBtn);
         addChild(_stepBtn);
         addChild(_equipView);
         _tabPageUtil = new TabPageUtil();
         _tabPageUtil.addItemPage(_strengthBtn,creatStrengthView);
         _tabPageUtil.addItemPage(_stepBtn,creatStepView);
         _tabPageUtil.selectIndex = 0;
      }
      
      private function get model() : GodDessModel
      {
         return GodDessManager.instance.model;
      }
      
      private function chooseHandler(param1:String, param2:Object) : void
      {
         if(!_equipView)
         {
            return;
         }
         var _loc3_:GoddessInfo = param2 as GoddessInfo;
         data = _loc3_;
         morenChoose();
      }
      
      private function morenChoose() : void
      {
         if(!_data)
         {
            return;
         }
         var _loc1_:int = 1;
         _equipView.selectIndex = _loc1_;
         var _loc2_:GoddessEquipInfo = _data.equips[_loc1_];
         model.equipSelectInfo = _loc2_;
         var _loc3_:GoddessBaseEquipView = _tabPageUtil.selectPage as GoddessBaseEquipView;
         if(_loc3_)
         {
            _loc3_.data = _loc2_;
            if(_loc3_ is GoddessEquipStrengthView)
            {
               (_loc3_ as GoddessEquipStrengthView).isAuto = false;
            }
         }
      }
      
      private function updataHandler(param1:String, param2:Object) : void
      {
         data = _data;
         var _loc3_:GoddessBaseEquipView = _tabPageUtil.selectPage as GoddessBaseEquipView;
         if(_loc3_)
         {
            _loc3_.updateView();
         }
      }
      
      private function chooseEquipHandler(param1:String, param2:Object) : void
      {
         var _loc4_:GoddessEquipInfo = param2 as GoddessEquipInfo;
         model.equipSelectInfo = _loc4_;
         var _loc3_:GoddessBaseEquipView = _tabPageUtil.selectPage as GoddessBaseEquipView;
         if(_loc3_)
         {
            _loc3_.data = _loc4_;
            if(_loc3_ is GoddessEquipStrengthView)
            {
               if(!_loc3_.isSameData)
               {
                  (_loc3_ as GoddessEquipStrengthView).isAuto = false;
               }
            }
         }
      }
      
      private function set data(param1:GoddessInfo) : void
      {
         _data = param1;
         _equipView.data = _data;
      }
      
      private function creatStrengthView() : GoddessEquipStrengthView
      {
         var _loc1_:GoddessEquipStrengthView = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.view.GoddessEquipStrengthView");
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function creatStepView() : GoddessEquipStepView
      {
         var _loc1_:GoddessEquipStepView = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.view.GoddessEquipStepView");
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function initEvent() : void
      {
         MsgMan.addObserver("GodDessEvent.choose",this,chooseHandler);
         MsgMan.addObserver("EVENT_CHANGE_EQUIP",this,chooseEquipHandler);
         MsgMan.addObserver("EVENT_EQUIP_UPDATA",this,updataHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("GodDessEvent.choose",this,chooseHandler);
         MsgMan.removeObserver("EVENT_CHANGE_EQUIP",this,chooseEquipHandler);
         MsgMan.removeObserver("EVENT_EQUIP_UPDATA",this,updataHandler);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_eqBG);
         _eqBG = null;
         ObjectUtils.disposeObject(_strengthBtn);
         _strengthBtn = null;
         ObjectUtils.disposeObject(_stepBtn);
         _stepBtn = null;
         ObjectUtils.disposeObject(_tabPageUtil);
         _tabPageUtil = null;
         ObjectUtils.disposeObject(_equipView);
         _equipView = null;
         super.dispose();
         _data = null;
      }
   }
}

