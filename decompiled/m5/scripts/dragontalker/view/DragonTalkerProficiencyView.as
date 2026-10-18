package dragontalker.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dragontalker.item.DragonTalkerProficiencyItem;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import utils.LogicUtils;
   import yishi.utils.MsgMan;
   
   public class DragonTalkerProficiencyView extends Component
   {
      
      private var _itemVbox:VBox;
      
      private var _tipText:FilterFrameText;
      
      private var _viewBack:MutipleImage;
      
      private var itemList:Vector.<DragonTalkerProficiencyItem>;
      
      public function DragonTalkerProficiencyView()
      {
         super();
         initView();
         initSkillView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _itemVbox = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n2_b4rj.itemVbox");
         _tipText = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.b4rj3o_n1_b4rj");
         _viewBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.b4rj3o.viewBack");
         addChild(_viewBack);
         addChild(_tipText);
         addChild(_itemVbox);
         _tipText.text = LanguageMgr.GetTranslation("DragonTalkerProficiencyView.tipText.text");
      }
      
      private function initSkillView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DragonTalkerProficiencyItem = null;
         itemList = new Vector.<DragonTalkerProficiencyItem>();
         _loc2_ = 1;
         while(_loc2_ <= 4)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("DragonTalkerProficiencyView.item",[_loc2_]);
            _itemVbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateProficiencyHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("DRAGON_TALKER_INFO_UPDATE",this,__updateProficiencyHandler);
      }
      
      private function __updateProficiencyHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DragonTalkerProficiencyItem = null;
         _loc2_ = 1;
         while(_loc2_ <= 4)
         {
            _loc1_ = itemList[_loc2_ - 1];
            _loc1_.data = _loc2_ - 1 < model.proficiencyList.length ? model.getProficiencyInfoByIndex(_loc2_) : null;
            _loc2_++;
         }
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemVbox);
         _itemVbox = null;
         ObjectUtils.disposeObject(_tipText);
         _tipText = null;
         ObjectUtils.disposeObject(_viewBack);
         _viewBack = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

