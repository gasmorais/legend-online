package war2023
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import mvc.module.war2023.SecretWarModel;
   import war2023.util.SecretwarBitDataUtil;
   import war2023.view.SecretwarResultListView;
   import war2023.view.SecretwarResultView;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.NotificationManager;
   import yishi.manager.SecretWarManager;
   
   public class SecretwarResultFrame extends Frame implements IManualSize
   {
      
      private var _bg:MutipleImage;
      
      private var _view:SecretwarResultListView;
      
      private var _bottomView:SecretwarResultView;
      
      private var _winOrLost:Bitmap;
      
      private var _blueScoreTxt:FilterFrameText;
      
      private var _redScoreTxt:FilterFrameText;
      
      public function SecretwarResultFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,1040,570);
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.resultbigg");
         _blueScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.result.blueScoreTxt");
         _redScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.result.redScoreTxt");
         _view = new SecretwarResultListView();
         _bottomView = new SecretwarResultView();
         if(model.selfPlay && model.resultInfo.winCamp == model.selfPlay.camp)
         {
            _winOrLost = ComponentFactory.Instance.creatBitmap("asset.secretwar.result.win");
         }
         else
         {
            _winOrLost = ComponentFactory.Instance.creatBitmap("asset.secretwar.result.lost");
         }
         addToContent(_bg);
         addToContent(_view);
         addToContent(_bottomView);
         addToContent(_winOrLost);
         addToContent(_blueScoreTxt);
         addToContent(_redScoreTxt);
         _view.x = 131;
         _view.y = 50;
         _bottomView.x = 172;
         _bottomView.y = 70;
         _blueScoreTxt.text = "" + model.resultInfo.blueScore;
         _redScoreTxt.text = "" + model.resultInfo.redScore;
      }
      
      private function get model() : SecretWarModel
      {
         return SecretWarManager.Instance.model;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         NotificationManager.instance.addEventListener("secretwarRewardEvent",updateResultHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         NotificationManager.instance.removeEventListener("secretwarRewardEvent",updateResultHandler);
      }
      
      private function updateResultHandler(param1:Event) : void
      {
         if(_bottomView)
         {
            _bottomView.updateView();
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeObject(_bottomView);
         _bottomView = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_redScoreTxt);
         _redScoreTxt = null;
         ObjectUtils.disposeObject(_blueScoreTxt);
         _blueScoreTxt = null;
         ObjectUtils.disposeObject(_winOrLost);
         _winOrLost = null;
         super.dispose();
         SecretwarBitDataUtil.clearBitDatas();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

