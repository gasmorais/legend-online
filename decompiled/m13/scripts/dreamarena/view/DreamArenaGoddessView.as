package dreamarena.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import dreamarena.item.DreamArenaGoddessRightItem;
   import utils.LogicUtils;
   import yishi.manager.TempleteManager;
   
   public class DreamArenaGoddessView extends Component
   {
      
      private var _goddessVbox:VBox;
      
      private var goddessList:Vector.<DreamArenaGoddessRightItem>;
      
      public function DreamArenaGoddessView()
      {
         super();
         initView();
         initListView();
      }
      
      private function initView() : void
      {
         _goddessVbox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaGoddessView.goddessVbox");
         addChild(_goddessVbox);
      }
      
      private function initListView() : void
      {
         var _loc1_:DreamArenaGoddessRightItem = null;
         var _loc2_:int = 0;
         goddessList = new Vector.<DreamArenaGoddessRightItem>();
         var _loc3_:Array = TempleteManager.instance.dreamArenaTempCate.getTemplateByType(5);
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc1_ = new DreamArenaGoddessRightItem(_loc2_ + 1);
            _loc1_.tempInfo = _loc3_[_loc2_];
            _loc1_.refreshSkillView();
            _goddessVbox.addChild(_loc1_);
            goddessList.push(_loc1_);
            _loc2_++;
         }
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DreamArenaGoddessRightItem = null;
         _loc2_ = 0;
         while(_loc2_ < goddessList.length)
         {
            _loc1_ = goddessList[_loc2_] as DreamArenaGoddessRightItem;
            _loc1_.refreshSkillView();
            _loc2_++;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_goddessVbox);
         _goddessVbox = null;
         LogicUtils.disposeDisplayCollection(goddessList);
         goddessList = null;
         super.dispose();
      }
   }
}

