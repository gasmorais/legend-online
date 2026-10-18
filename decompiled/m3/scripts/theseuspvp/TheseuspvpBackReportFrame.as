package theseuspvp
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.theseuspvp.TheseusPvpLeaveReportInfo;
   import yishi.datas.ComponentGroupType;
   
   public class TheseuspvpBackReportFrame extends Frame
   {
      
      public var _backBg:Bitmap;
      
      public var _backDesTxt:FilterFrameText;
      
      public var _backRow1:Image;
      
      public var _backSIdx:FilterFrameText;
      
      public var _backRow2:Image;
      
      public var _backScore:FilterFrameText;
      
      public var _backSidxC1:FilterFrameText;
      
      public var _backSidxC2:FilterFrameText;
      
      private var _btn:IconButton;
      
      public function TheseuspvpBackReportFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _backBg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.backBg");
         _backDesTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.backDesTxt");
         _backRow1 = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.backRow1");
         _backSIdx = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.backSIdx");
         _backRow2 = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.backRow2");
         _backScore = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.backScore");
         _backSidxC1 = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.backSidxC1");
         _backSidxC2 = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.backSidxC2");
         _btn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.backReportBtn");
         addToContent(_backBg);
         addToContent(_backDesTxt);
         addToContent(_backRow1);
         addToContent(_backSIdx);
         addToContent(_backRow2);
         addToContent(_backScore);
         addToContent(_backSidxC1);
         addToContent(_backSidxC2);
         addToContent(_btn);
         _backDesTxt.text = LanguageMgr.GetTranslation("theseuspvp.levelReportDes");
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _btn.addEventListener("click",clickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _btn.removeEventListener("click",clickHandler);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         dispose();
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
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function show(param1:TheseusPvpLeaveReportInfo) : void
      {
         titleText = LanguageMgr.GetTranslation("theseuspvp.reportTitle");
         refreshView(param1);
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function refreshView(param1:TheseusPvpLeaveReportInfo) : void
      {
         _backSIdx.text = LanguageMgr.GetTranslation("theseuspvp.result.sort",param1.lastRank);
         _backScore.text = LanguageMgr.GetTranslation("theseuspvp.result.score",param1.lastIntegral);
         var _loc3_:String = "";
         var _loc2_:int = param1.rank - param1.lastRank;
         if(_loc2_ == 0)
         {
            _loc3_ = "0";
         }
         else if(_loc2_ > 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("public.downArrow") + _loc2_;
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("public.upArrow") + Math.abs(_loc2_);
         }
         _backSidxC1.htmlText = LanguageMgr.GetTranslation("theseuspvp.change",param1.rank,_loc3_);
         _loc2_ = param1.integral - param1.lastIntegral;
         if(_loc2_ == 0)
         {
            _loc3_ = "0";
         }
         else if(_loc2_ > 0)
         {
            _loc3_ = "+" + _loc2_;
         }
         else
         {
            _loc3_ = "" + _loc2_;
         }
         _backSidxC2.htmlText = LanguageMgr.GetTranslation("theseuspvp.change",param1.integral,_loc3_);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_backBg);
         _backBg = null;
         ObjectUtils.disposeObject(_backDesTxt);
         _backDesTxt = null;
         ObjectUtils.disposeObject(_backRow1);
         _backRow1 = null;
         ObjectUtils.disposeObject(_backSIdx);
         _backSIdx = null;
         ObjectUtils.disposeObject(_backRow2);
         _backRow2 = null;
         ObjectUtils.disposeObject(_backScore);
         _backScore = null;
         ObjectUtils.disposeObject(_backSidxC1);
         _backSidxC1 = null;
         ObjectUtils.disposeObject(_backSidxC2);
         _backSidxC2 = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         super.dispose();
      }
   }
}

