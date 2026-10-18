package colosseum.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.SortEvent;
   import flash.display.Sprite;
   import mvc.controler.SortController;
   import mvc.module.sort.SortData;
   import yishi.manager.FrameControllerManager;
   
   public class ChallengeLeftView extends Sprite implements Disposeable
   {
      
      private var _vbox:VBox;
      
      private var item_1:ChallengeLeftItemView;
      
      private var item_2:ChallengeLeftItemView;
      
      private var item_3:ChallengeLeftItemView;
      
      public function ChallengeLeftView()
      {
         super();
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         _vbox = ComponentFactory.Instance.creatComponentByStylename("colosseum.challengeLeftView.vbox");
         addChild(_vbox);
         item_1 = ComponentFactory.Instance.creatCustomObject("colosseum.ChallengeLeftItemView");
         item_2 = ComponentFactory.Instance.creatCustomObject("colosseum.ChallengeLeftItemView");
         item_3 = ComponentFactory.Instance.creatCustomObject("colosseum.ChallengeLeftItemView");
         item_1.data = null;
         item_1.index = 1;
         _vbox.addChild(item_1);
         item_2.data = null;
         item_2.index = 2;
         _vbox.addChild(item_2);
         item_3.data = null;
         item_3.index = 3;
         _vbox.addChild(item_3);
      }
      
      private function initEvent() : void
      {
         sortController.model.addEventListener("SELECTE_LIST_CHANG",__listChangeHandler);
      }
      
      private function removeEvent() : void
      {
         sortController.model.removeEventListener("SELECTE_LIST_CHANG",__listChangeHandler);
      }
      
      private function __listChangeHandler(param1:SortEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         if(sortController.model.playerFightList.length > 0)
         {
            for each(var _loc3_:SortData in sortController.model.playerFightList)
            {
               if(!item_1.data)
               {
                  item_1.data = _loc3_;
                  _loc5_++;
                  _loc4_ = int(_loc3_.army.baseHero.templateInfo.Job);
               }
               else if(!item_2.data && _loc3_.army.baseHero.templateInfo.Job != _loc4_)
               {
                  item_2.data = _loc3_;
                  _loc5_++;
                  _loc2_ = int(_loc3_.army.baseHero.templateInfo.Job);
               }
               else if(!item_3.data && _loc3_.army.baseHero.templateInfo.Job != _loc4_ && _loc3_.army.baseHero.templateInfo.Job != _loc2_)
               {
                  item_3.data = _loc3_;
                  _loc5_++;
                  break;
               }
            }
         }
      }
      
      private function get sortController() : SortController
      {
         return FrameControllerManager.instance.sortController;
      }
      
      private function initData() : void
      {
         var _loc1_:SortData = null;
         while(sortController.model.playerFightList.length > 0)
         {
            _loc1_ = sortController.model.playerFightList.pop() as SortData;
            if(_loc1_)
            {
               _loc1_.army.dispose();
               _loc1_.army = null;
               _loc1_ = null;
            }
         }
         sortController.model.currentSelected = 2;
         sortController.loadData("fight.xml");
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(item_1);
         item_1 = null;
         ObjectUtils.disposeObject(item_2);
         item_2 = null;
         ObjectUtils.disposeObject(item_3);
         item_3 = null;
         ObjectUtils.disposeAllChildren(_vbox);
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
      }
   }
}

