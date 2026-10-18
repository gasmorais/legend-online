package marry.income
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.marry.MarrySender;
   
   public class SearchMateView extends Sprite implements Disposeable
   {
      
      private var _searchMateButton:BaseButton;
      
      public function SearchMateView()
      {
         super();
         _searchMateButton = ComponentFactory.Instance.creatComponentByStylename("SearchMateView.searchButton");
         addChild(_searchMateButton);
         _searchMateButton.addEventListener("click",__searchMatesHandler);
      }
      
      private function __searchMatesHandler(param1:MouseEvent) : void
      {
         MarrySender.findMates();
      }
      
      public function dispose() : void
      {
         if(_searchMateButton)
         {
            _searchMateButton.removeEventListener("click",__searchMatesHandler);
         }
         if(_searchMateButton)
         {
            _searchMateButton.dispose();
         }
         _searchMateButton = null;
      }
   }
}

