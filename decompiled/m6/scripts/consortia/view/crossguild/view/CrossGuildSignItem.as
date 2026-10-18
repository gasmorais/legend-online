package consortia.view.crossguild.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import manager.LanguageMgr;
   import yishi.utils.NumberViewUtils;
   
   public class CrossGuildSignItem extends Component
   {
      
      private var _back:MutipleImage;
      
      private var _numbit:BitmapData;
      
      private var _numContiner1:Component;
      
      private var _numContiner2:Component;
      
      private var _descText:FilterFrameText;
      
      private var defendNum:int;
      
      public function CrossGuildSignItem()
      {
         super();
         defendNum = 12;
         initView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("CrossGuildSignItem.back");
         _numbit = ComponentFactory.Instance.creatBitmapData("asset.CrossGuildSignItem.numbit");
         _numContiner1 = ComponentFactory.Instance.creatComponentByStylename("CrossGuildSignItem.numContiner1");
         _numContiner2 = ComponentFactory.Instance.creatComponentByStylename("CrossGuildSignItem.numContiner2");
         _descText = ComponentFactory.Instance.creatComponentByStylename("CrossGuildSignItem.descText");
         addChild(_back);
         addChild(_numContiner1);
         addChild(_numContiner2);
         addChild(_descText);
         _descText.text = LanguageMgr.GetTranslation("CrossGuildSignItem.descText.text",defendNum);
         NumberViewUtils.refreshValue(defendNum,_numContiner1,_numbit,18,20,10,18,"0123456789");
         NumberViewUtils.refreshValue(defendNum,_numContiner2,_numbit,18,20,10,18,"0123456789");
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_numbit);
         _numbit = null;
         ObjectUtils.disposeObject(_numContiner1);
         _numContiner1 = null;
         ObjectUtils.disposeObject(_numContiner2);
         _numContiner2 = null;
         ObjectUtils.disposeObject(_descText);
         _descText = null;
         super.dispose();
      }
   }
}

