package colosseum.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ChallengeManager;
   import mvc.controler.ColosseumControler;
   import mvc.module.colosseum.ColosseumEventData;
   import mvc.module.colosseum.ColosseumModel;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   
   public class ColosseumEventFrame extends Frame implements IManualSize
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox1:VBox;
      
      private var _vBox2:VBox;
      
      private var _content:Sprite;
      
      public function ColosseumEventFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,525,280);
      }
      
      private function initView() : void
      {
         var _loc4_:Bitmap = null;
         var _loc6_:ColosseumEventData = null;
         var _loc1_:ColosseumEventItem = null;
         _back = ComponentFactory.Instance.creatComponentByStylename("colosseum.ColossumEventFrameBack");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("colosseum.ScrollPanel");
         _vBox1 = ComponentFactory.Instance.creatComponentByStylename("colosseum.EventBox1");
         _vBox2 = ComponentFactory.Instance.creatComponentByStylename("colosseum.EventBox2");
         addToContent(_back);
         addToContent(_scrollPanel);
         _content = new Sprite();
         _content.addChild(_vBox1);
         _content.addChild(_vBox2);
         _scrollPanel.setView(_content);
         var _loc5_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < 7)
         {
            _loc4_ = ComponentFactory.Instance.creatBitmap("asset.colosseum.LogtFrameLine");
            _vBox1.addChild(_loc4_);
            _loc5_++;
         }
         var _loc2_:Vector.<ColosseumEventData> = model.eventsList;
         var _loc3_:int = int(_loc2_.length);
         _loc2_.sort(sortOnDate);
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc6_ = _loc2_[_loc5_];
            _loc1_ = new ColosseumEventItem();
            _loc1_.data = _loc6_;
            _vBox2.addChild(_loc1_);
            if(_loc5_ < _loc3_ - 1 && _loc5_ >= 7)
            {
               _loc4_ = ComponentFactory.Instance.creatBitmap("asset.colosseum.LogtFrameLine");
               _vBox1.addChild(_loc4_);
            }
            _loc5_++;
         }
         _vBox1.refreshChildPos();
         _vBox2.refreshChildPos();
         _scrollPanel.invalidateViewport();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               control.closeEventFrame();
         }
      }
      
      private function sortOnDate(param1:ColosseumEventData, param2:ColosseumEventData) : int
      {
         if(param1.logDate.getTime() > param2.logDate.getTime())
         {
            return -1;
         }
         if(param1.logDate.getTime() == param2.logDate.getTime())
         {
            return 0;
         }
         return 1;
      }
      
      private function get model() : ColosseumModel
      {
         return ChallengeManager.instance.model;
      }
      
      private function get control() : ColosseumControler
      {
         return FrameControllerManager.instance.colosseumControler;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("emailII.EmailFrame.battle");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_vBox1);
         _vBox1 = null;
         ObjectUtils.disposeObject(_vBox2);
         _vBox2 = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

