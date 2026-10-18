package fish.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.FishManager;
   import mvc.module.fish.FishModel;
   
   public class FishSortFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _scaleBg:Scale9CornerImage;
      
      private var _list:FishSortView;
      
      private var _scoreBitmap:Bitmap;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _sortBitmap:Bitmap;
      
      private var _sortBg:Bitmap;
      
      private var _sortTxt:FilterFrameText;
      
      public function FishSortFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("fish.FishSortFrame.title");
         _bg = ComponentFactory.Instance.creatComponentByStylename("fish.FishSortBg");
         _scaleBg = ComponentFactory.Instance.creatComponentByStylename("fish.FishSortListBG");
         _list = new FishSortView();
         _scoreBitmap = ComponentFactory.Instance.creatBitmap("asset.FishSort.score");
         _sortBitmap = ComponentFactory.Instance.creatBitmap("asset.FishSort.sort");
         _sortBg = ComponentFactory.Instance.creatBitmap("asset.FishSort.sortBg");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("fish.FishSort.score");
         _sortTxt = ComponentFactory.Instance.creatComponentByStylename("fish.FishSort.sort");
         addToContent(_bg);
         addToContent(_scaleBg);
         addToContent(_list);
         addToContent(_scoreBitmap);
         addToContent(_sortBitmap);
         addToContent(_sortBg);
         addToContent(_scoreTxt);
         addToContent(_sortTxt);
         _scoreTxt.text = model.fishPoolInfo.score.toString();
         _sortTxt.text = model.fishPoolInfo.sort.toString();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_scaleBg);
         _scaleBg = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function get model() : FishModel
      {
         return FishManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
   }
}

