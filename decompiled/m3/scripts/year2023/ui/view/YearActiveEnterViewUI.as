package year2023.ui.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import year2023.ui.item.YearActive1UI;
   import year2023.ui.item.YearActive2UI;
   import year2023.ui.item.YearActive3UI;
   import year2023.ui.item.YearActive4UI;
   import year2023.ui.item.YearActive5UI;
   import year2023.ui.item.YearActive6UI;
   
   public class YearActiveEnterViewUI extends Sprite
   {
      
      protected var _typeBg2:MovieClip;
      
      protected var _dayItem1:YearActive1UI;
      
      protected var _dayItem3:YearActive3UI;
      
      protected var _dayItem2:YearActive2UI;
      
      protected var _dayItem4:YearActive4UI;
      
      protected var _dayItem5:YearActive5UI;
      
      protected var _dayItem6:YearActive6UI;
      
      protected var _enterTimeTxt:FilterFrameText;
      
      public function YearActiveEnterViewUI()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _typeBg2 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.typeBg2");
         _dayItem1 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.dayItem1");
         _dayItem3 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.dayItem3");
         _dayItem2 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.dayItem2");
         _dayItem4 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.dayItem4");
         _dayItem5 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.dayItem5");
         _dayItem6 = ComponentFactory.Instance.creatCustomObject("ui.yearactive.dayItem6");
         _enterTimeTxt = ComponentFactory.Instance.creatComponentByStylename("ui.yearactive.enterTimeTxt");
         addChild(_typeBg2);
         addChild(_dayItem1);
         addChild(_dayItem3);
         addChild(_dayItem2);
         addChild(_dayItem4);
         addChild(_dayItem5);
         addChild(_dayItem6);
         addChild(_enterTimeTxt);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeViolentMc(_typeBg2);
         _typeBg2 = null;
         ObjectUtils.disposeObject(_dayItem1);
         _dayItem1 = null;
         ObjectUtils.disposeObject(_dayItem3);
         _dayItem3 = null;
         ObjectUtils.disposeObject(_dayItem2);
         _dayItem2 = null;
         ObjectUtils.disposeObject(_dayItem4);
         _dayItem4 = null;
         ObjectUtils.disposeObject(_dayItem5);
         _dayItem5 = null;
         ObjectUtils.disposeObject(_dayItem6);
         _dayItem6 = null;
         ObjectUtils.disposeObject(_enterTimeTxt);
         _enterTimeTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

