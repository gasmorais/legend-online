package petboss
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import yishi.utils.MsgMan;
   
   public class PetBossFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      private var itemObj:Object = {};
      
      public function PetBossFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PetbossItem = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("PetBossFrame.bg");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("PetBossFrame.Vbox");
         addToContent(_bg);
         addToContent(_vBox);
         titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.petBossBtn.tipData");
         _loc2_ = 0;
         while(_loc2_ < 1)
         {
            _loc1_ = new PetbossItem();
            _vBox.addChild(_loc1_);
            itemObj[_loc2_] = _loc1_;
            _loc2_++;
         }
         _bg.height = 95;
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = _bg.height + 85;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         MsgMan.addObserver("PetEvent.PET_BOSS_ITEM_CLICK",this,__clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         MsgMan.removeObserver("PetEvent.PET_BOSS_ITEM_CLICK",this,__clickHandler);
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
      
      private function __clickHandler(param1:String, param2:Object) : void
      {
         dispose();
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_vBox)
         {
            _vBox.dispose();
         }
         _vBox = null;
         super.dispose();
      }
   }
}

