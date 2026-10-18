package consortia.view.minos
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.minos.ui.MinosSeasonRewardItemUI;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   
   public class MinosSeaonRewardFrame extends Frame implements IManualSize
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _panel:ScrollPanel;
      
      private var _desTxt:FilterFrameText;
      
      private var _vbox:VBox;
      
      public function MinosSeaonRewardFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,580,538);
      }
      
      private function initView() : void
      {
         var _loc1_:MinosSeasonRewardItemUI = null;
         var _loc3_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("ui.minos.gjBigBg");
         _panel = ComponentFactory.Instance.creatComponentByStylename("ui.minos.gjScrollpanel");
         _desTxt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.gjDesTxt");
         _vbox = new VBox();
         addToContent(_bg);
         addToContent(_panel);
         addToContent(_desTxt);
         _panel.setView(_vbox);
         _desTxt.text = LanguageMgr.GetTranslation("minos.season.des",1000);
         var _loc4_:Array = TempleteManager.instance.minosRewardCate.getTempListBy(1);
         var _loc2_:int = int(_loc4_.length);
         _vbox.beginChanges();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new MinosSeasonRewardItemUI();
            _loc1_.temp = _loc4_[_loc3_];
            _vbox.addChild(_loc1_);
            _loc3_++;
         }
         _vbox.commitChanges();
         _panel.invalidateViewport();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         playerInfo.addEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         playerInfo.removeEventListener("CONSORTIA_CHANGE",__existConsortiaHandler);
      }
      
      private function __existConsortiaHandler(param1:PlayerEvent) : void
      {
         if(playerInfo.consortiaID == 0)
         {
            dispose();
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
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
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_desTxt);
         _desTxt = null;
         super.dispose();
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("minos.season.frame");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

