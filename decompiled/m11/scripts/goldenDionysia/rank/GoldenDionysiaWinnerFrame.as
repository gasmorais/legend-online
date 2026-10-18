package goldenDionysia.rank
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.exchargerank.ExchargeRankData;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.GoldenDionysiaManager;
   
   public class GoldenDionysiaWinnerFrame extends Frame implements IManualSize
   {
      
      private var _rankView:GoldenDionysiaRankView;
      
      public function GoldenDionysiaWinnerFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,383,365);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         this.titleText = LanguageMgr.GetTranslation("warlords.WarlordsBetFrame.str03");
         _rankView = new GoldenDionysiaRankView();
         addToContent(_rankView);
         var _loc1_:Vector.<ExchargeRankData> = GoldenDionysiaManager.instance.getLuckyRankList(2);
         _rankView.type = 2;
         _rankView.updateUI(_loc1_,2);
      }
      
      private function addEvent() : void
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
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_rankView);
         _rankView = null;
         super.dispose();
      }
   }
}

