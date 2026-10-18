package map.campaign.view.ui.secretland
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaSecretInfo;
   import yishi.view.community.TimeDownView;
   
   public class ConsortiaSecretTimeView extends Component
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _collectText:FilterFrameText;
      
      private var _collectValueText:FilterFrameText;
      
      private var _getExpText:FilterFrameText;
      
      private var _downTime:TimeDownView;
      
      private var _data:ConsortiaSecretInfo;
      
      public function ConsortiaSecretTimeView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         mouseEnabled = mouseChildren = false;
         _back = ComponentFactory.Instance.creatComponentByStylename("campaign.ConsortiaSecretTimeBack");
         _collectText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretTimeView.collectText");
         _collectValueText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretTimeView.collectValueText");
         _getExpText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaSecretTimeView.getExpText");
         _downTime = ComponentFactory.Instance.creatComponentByStylename("campaign.ConsortiaSecretGainDownTime");
         addChild(_back);
         addChild(_collectText);
         addChild(_collectValueText);
         addChild(_getExpText);
         addChild(_downTime);
         _back.width = 400;
      }
      
      public function setData(param1:ConsortiaSecretInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         clean();
         if(_data)
         {
            _back.visible = true;
            _downTime.visible = true;
            _downTime.timeCount = _data.countDown;
            _collectText.text = LanguageMgr.GetTranslation("ConsortiaSecretTimeView.collectText.text" + _data.secretState);
            if(_data.secretState == 3)
            {
               _collectValueText.text = _data.collectRate.toFixed(2);
               _getExpText.text = LanguageMgr.GetTranslation("ConsortiaSecretTimeView.getExpText.text");
               _collectText.y = _collectValueText.y = 8;
               _downTime.y = 27;
               _downTime.x = 212;
            }
            else
            {
               _collectText.y = _collectValueText.y = 13;
               _downTime.y = 13;
               _downTime.x = 322;
            }
         }
      }
      
      private function clean() : void
      {
         _back.visible = false;
         _collectText.text = "";
         _collectValueText.text = "";
         _getExpText.text = "";
         _downTime.timeCount = 0;
         _downTime.visible = false;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,false,false);
      }
      
      override public function dispose() : void
      {
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_collectText)
         {
            ObjectUtils.disposeObject(_collectText);
         }
         _collectText = null;
         if(_collectValueText)
         {
            ObjectUtils.disposeObject(_collectValueText);
         }
         _collectValueText = null;
         if(_getExpText)
         {
            ObjectUtils.disposeObject(_getExpText);
         }
         _getExpText = null;
         if(_downTime)
         {
            ObjectUtils.disposeObject(_downTime);
         }
         _downTime = null;
         super.dispose();
      }
   }
}

