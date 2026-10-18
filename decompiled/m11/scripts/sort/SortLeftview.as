package sort
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mvc.controler.SortController;
   import mvc.module.sort.SortModel;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   
   public class SortLeftview extends Sprite implements Disposeable
   {
      
      private var _numberOneBtn:IconButton;
      
      private var _selfPowBtn:SelectedButton;
      
      private var _petPowerBtn:SelectedButton;
      
      private var _childPowerBtn:SelectedButton;
      
      private var _multiplePowBtn:SelectedButton;
      
      private var _consortiaPowBtn:SelectedButton;
      
      private var _soulBtn:SelectedButton;
      
      private var _selfLevelBtn:SelectedButton;
      
      private var _honourBtn:SelectedButton;
      
      private var _charmsBtn:SelectedButton;
      
      private var _theseusBtn:SelectedButton;
      
      private var _tabBox:VBox;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _model:SortModel;
      
      private var _controller:SortController;
      
      private var _recall:Function;
      
      public function SortLeftview(param1:SortModel, param2:SortController, param3:Function)
      {
         super();
         _model = param1;
         _controller = param2;
         _recall = param3;
         initView();
         addEvent();
         if(_model.currentSelected != 12)
         {
            _model.addType = 3;
            _buttonGroup.selectIndex = 0;
         }
      }
      
      private function initView() : void
      {
         _numberOneBtn = ComponentFactory.Instance.creatComponentByStylename("sort.numberone.btnshoubang");
         _selfLevelBtn = ComponentFactory.Instance.creatComponentByStylename("sort.selfLevelBtn");
         _selfPowBtn = ComponentFactory.Instance.creatComponentByStylename("sort.selfPowBtn");
         _multiplePowBtn = ComponentFactory.Instance.creatComponentByStylename("sort.consortiaLevelBtn");
         _consortiaPowBtn = ComponentFactory.Instance.creatComponentByStylename("sort.consortiaPowBtn");
         _honourBtn = ComponentFactory.Instance.creatComponentByStylename("sort.honourBtn");
         _charmsBtn = ComponentFactory.Instance.creatComponentByStylename("sort.charmsBtn");
         _soulBtn = ComponentFactory.Instance.creatComponentByStylename("sort.SoulBtn");
         _petPowerBtn = ComponentFactory.Instance.creatComponentByStylename("sort.petPowBtn");
         _childPowerBtn = ComponentFactory.Instance.creatComponentByStylename("sort.childPowBtn");
         _theseusBtn = ComponentFactory.Instance.creatComponentByStylename("sort.theseusBtn");
         _tabBox = ComponentFactory.Instance.creatComponentByStylename("sort.tabBox");
         _buttonGroup = new SelectedButtonGroup();
         _buttonGroup.addSelectItem(_selfPowBtn);
         _buttonGroup.addSelectItem(_petPowerBtn);
         _buttonGroup.addSelectItem(_childPowerBtn);
         _buttonGroup.addSelectItem(_multiplePowBtn);
         _buttonGroup.addSelectItem(_consortiaPowBtn);
         _buttonGroup.addSelectItem(_soulBtn);
         _buttonGroup.addSelectItem(_selfLevelBtn);
         _buttonGroup.addSelectItem(_honourBtn);
         _buttonGroup.addSelectItem(_charmsBtn);
         _buttonGroup.addSelectItem(_theseusBtn);
         addChild(_numberOneBtn);
         addChild(_tabBox);
         _tabBox.addChild(_selfPowBtn);
         _tabBox.addChild(_petPowerBtn);
         _tabBox.addChild(_childPowerBtn);
         _tabBox.addChild(_multiplePowBtn);
         _tabBox.addChild(_consortiaPowBtn);
         _tabBox.addChild(_soulBtn);
         _tabBox.addChild(_selfLevelBtn);
         _tabBox.addChild(_honourBtn);
         _tabBox.addChild(_charmsBtn);
         _tabBox.addChild(_theseusBtn);
      }
      
      private function uninit() : void
      {
         _buttonGroup.dispose();
         _buttonGroup = null;
         ObjectUtils.disposeAllChildren(this);
         _model = null;
         _controller = null;
         _numberOneBtn = null;
         _selfPowBtn = null;
         _petPowerBtn = null;
         _childPowerBtn = null;
         _multiplePowBtn = null;
         _consortiaPowBtn = null;
         _soulBtn = null;
         _selfLevelBtn = null;
         _honourBtn = null;
         _charmsBtn = null;
         _recall = null;
      }
      
      private function addEvent() : void
      {
         _buttonGroup.addEventListener("change",__onChangeHandler);
         _numberOneBtn.addEventListener("click",numberoneHandler);
      }
      
      protected function numberoneHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:Array = [];
         if(_model.playerFightList == null || _model.playerFightList.length == 0)
         {
            _loc3_ = PathManager.orderPath + "fight.xml";
            _loc2_.push(_loc3_);
         }
         if(_model.accumulationAddList == null || _model.accumulationAddList.length == 0)
         {
            _loc3_ = PathManager.orderPath + "total.xml";
            _loc2_.push(_loc3_);
         }
         if(_model.playerHonourList == null || _model.playerHonourList.length == 0)
         {
            _loc3_ = PathManager.orderPath + "geste.xml";
            _loc2_.push(_loc3_);
         }
         if(_model.charmsTotalAddList == null || _model.charmsTotalAddList.length == 0)
         {
            _loc3_ = PathManager.orderPath + "totalcharm.xml";
            _loc2_.push(_loc3_);
         }
         if(_model.soulScoreTotalAddList == null || _model.soulScoreTotalAddList.length == 0)
         {
            _loc3_ = PathManager.orderPath + "soulscore.xml";
            _loc2_.push(_loc3_);
         }
         if(_model.petPowerList == null || _model.petPowerList.length == 0)
         {
            _loc3_ = PathManager.orderPath + "petfightcapacityrank.xml";
            _loc2_.push(_loc3_);
         }
         if(_loc2_.length > 0)
         {
            _controller.loadAllLocalXML(_loc2_,showNumberOne);
         }
         else
         {
            showNumberOne();
         }
      }
      
      private function showNumberOne() : void
      {
         FrameControllerManager.instance.openControllerByInfo("shoubang");
         if(_recall != null)
         {
            _recall.call(null);
         }
      }
      
      private function remveEvent() : void
      {
         _buttonGroup.removeEventListener("change",__onChangeHandler);
      }
      
      private function __onChangeHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("022");
         var _loc3_:ISelectable = _buttonGroup.getSelectedItem();
         switch(_loc3_)
         {
            case _selfPowBtn:
               _loc2_ = 2;
               break;
            case _petPowerBtn:
               _loc2_ = 9;
               break;
            case _childPowerBtn:
               _loc2_ = 13;
               break;
            case _multiplePowBtn:
               _loc2_ = 3;
               break;
            case _consortiaPowBtn:
               _loc2_ = 4;
               break;
            case _soulBtn:
               _loc2_ = 7;
               break;
            case _selfLevelBtn:
               _loc2_ = 1;
               break;
            case _honourBtn:
               _loc2_ = 5;
               break;
            case _charmsBtn:
               _loc2_ = 6;
               break;
            case _theseusBtn:
               _loc2_ = 14;
         }
         _controller.setSelectType(_loc2_);
      }
      
      public function dispose() : void
      {
         remveEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

