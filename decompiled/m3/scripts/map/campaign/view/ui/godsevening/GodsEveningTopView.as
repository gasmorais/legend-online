package map.campaign.view.ui.godsevening
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import map.campaign.view.ui.DownTimeView;
   import yishi.manager.GodsEveningManager;
   
   public class GodsEveningTopView extends Component
   {
      
      private var _bg:Image;
      
      private var _describe:Image;
      
      private var _downTime:DownTimeView;
      
      public function GodsEveningTopView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("GodsEveningTopView.Bg");
         _describe = ComponentFactory.Instance.creatComponentByStylename("GodsEveningTopView.Describe");
         _downTime = new DownTimeView(true);
         _downTime.x = 190;
         _downTime.y = -15;
         addChild(_bg);
         addChild(_describe);
         addChild(_downTime);
         _downTime.count = GodsEveningManager.instance.model.leftTime / 1000;
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_describe);
         _describe = null;
         ObjectUtils.disposeObject(_downTime);
         _downTime = null;
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,false,false);
      }
      
      override public function get width() : Number
      {
         return _bg.width;
      }
   }
}

