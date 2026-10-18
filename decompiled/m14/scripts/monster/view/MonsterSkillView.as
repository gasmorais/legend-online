package monster.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import monster.item.MonsterSkillLeranItem;
   import mvc.module.monster.MonsterModel;
   import utils.LogicUtils;
   import yishi.manager.MonsterManager;
   import yishi.utils.MsgMan;
   
   public class MonsterSkillView extends Component
   {
      
      private var _skillBack:Image;
      
      private var _activeBtn:SelectedIconButton;
      
      private var _passiveBtn:SelectedIconButton;
      
      private var _skillBox:VBox;
      
      private var _skillPanel:ScrollPanel;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var itemList:Vector.<MonsterSkillLeranItem>;
      
      public function MonsterSkillView()
      {
         super();
         initView();
         addEvent();
         _btnGroup.selectIndex = 0;
         refreshView();
      }
      
      private function initView() : void
      {
         _skillBack = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterSkillView.skillBack");
         _activeBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillView.activeBtn");
         _passiveBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillView.passiveBtn");
         _skillPanel = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillView.skillPanel");
         _skillBox = ComponentFactory.Instance.creatComponentByStylename("MonsterSkillView.skillBox");
         addChild(_skillBack);
         addChild(_activeBtn);
         addChild(_passiveBtn);
         addChild(_skillPanel);
         _skillPanel.setView(_skillBox);
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_activeBtn);
         _btnGroup.addSelectItem(_passiveBtn);
      }
      
      private function addEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__tabChangeHandler);
         }
         MsgMan.addObserver("MONSTER_INFO_CHANGE",this,__updateMonsterListHandler);
         MsgMan.addObserver("MONSTER_ITEM_SELECT",this,__updateSelectHandler);
      }
      
      private function removeEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__tabChangeHandler);
         }
         MsgMan.removeObserver("MONSTER_INFO_CHANGE",this,__updateMonsterListHandler);
         MsgMan.removeObserver("MONSTER_ITEM_SELECT",this,__updateSelectHandler);
      }
      
      private function __updateSelectHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __updateMonsterListHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __tabChangeHandler(param1:Event) : void
      {
         var _loc5_:int = 0;
         var _loc4_:MonsterSkillLeranItem = null;
         SoundManager.instance.play("022");
         _skillPanel.beginChanges();
         _skillBox.removeAllChild();
         itemList = new Vector.<MonsterSkillLeranItem>();
         var _loc2_:int = _btnGroup.selectIndex == 0 ? 1 : 2;
         var _loc3_:Array = model.getSkillViewShowList(model.selectMonster,_loc2_);
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc4_ = new MonsterSkillLeranItem();
            _loc4_.tempInfo = _loc5_ < _loc3_.length ? _loc3_[_loc5_] : null;
            _skillBox.addChild(_loc4_);
            itemList.push(_loc4_);
            _loc5_++;
         }
         _skillPanel.invalidateViewport();
         _skillPanel.commitChanges();
      }
      
      private function refreshView() : void
      {
         var _loc4_:int = 0;
         var _loc3_:MonsterSkillLeranItem = null;
         var _loc1_:int = _btnGroup.selectIndex == 0 ? 1 : 2;
         var _loc2_:Array = model.getSkillViewShowList(model.selectMonster,_loc1_);
         _loc4_ = 0;
         while(_loc4_ < itemList.length)
         {
            _loc3_ = itemList[_loc4_];
            _loc3_.tempInfo = _loc4_ < _loc2_.length ? _loc2_[_loc4_] : null;
            _loc4_++;
         }
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_skillBack);
         _skillBack = null;
         ObjectUtils.disposeObject(_activeBtn);
         _activeBtn = null;
         ObjectUtils.disposeObject(_passiveBtn);
         _passiveBtn = null;
         ObjectUtils.disposeObject(_skillPanel);
         _skillPanel = null;
         ObjectUtils.disposeObject(_skillBox);
         _skillBox = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

