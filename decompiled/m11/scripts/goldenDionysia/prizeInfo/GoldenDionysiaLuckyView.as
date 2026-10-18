package goldenDionysia.prizeInfo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.cccactive.GoldCrazyMsg;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.exchargerank.ExchargeRankData;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoldenDionysiaManager;
   
   public class GoldenDionysiaLuckyView extends Component
   {
      
      private var _luckyListBg:Bitmap;
      
      private var _luckyListNote:Bitmap;
      
      private var _frame1:ScaleBitmapImage;
      
      private var _frame2:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      private var _fallLinkTxt:FilterFrameText;
      
      public function GoldenDionysiaLuckyView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _luckyListBg = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.luckyListBg");
         _luckyListNote = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.luckyListNote");
         _frame1 = ComponentFactory.Instance.creatComponentByStylename("goldendionysia.bg");
         _frame2 = ComponentFactory.Instance.creatComponentByStylename("goldendionysia.bg");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("goldenDionysiaFrame.luckyListVBox");
         _fallLinkTxt = ComponentFactory.Instance.creatComponentByStylename("GoldenDionysiaLuckyView.fallItemsLinkTxt");
         addChild(_luckyListBg);
         addChild(_luckyListNote);
         addChild(_frame1);
         addChild(_frame2);
         addChild(_vBox);
         addChild(_fallLinkTxt);
         _frame1.scaleX = -1;
         _frame1.x = 175;
         _frame1.y = 27;
         _frame2.scaleX = -1;
         _frame2.scaleY = -1;
         _frame2.x = 175;
         _frame2.y = 117;
         var _loc1_:String = LanguageMgr.GetTranslation("GoldenDionysiaLuckyView.fallLink");
         _fallLinkTxt.htmlText = "<a href =\'event: \'><u><b>" + _loc1_ + "</b></u></a>";
         _fallLinkTxt.mouseEnabled = true;
         _fallLinkTxt.addEventListener("click",__fallLinkHandler);
      }
      
      public function update() : void
      {
         var _loc2_:int = 0;
         var _loc1_:FilterFrameText = null;
         var _loc4_:GoldCrazyMsg = GoldenDionysiaManager.instance.goldenMsg;
         var _loc3_:Vector.<ExchargeRankData> = GoldenDionysiaManager.instance.getLuckyRankList(2);
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(_loc2_ < 3)
            {
               _loc1_ = ComponentFactory.Instance.creatComponentByStylename("winCountInfo.luckyListTxt");
               _loc1_.text = LanguageMgr.GetTranslation("GoldenDionysiaItem.winCountTxt5",_loc3_[_loc2_].nickName);
               _loc1_.height = _loc1_.textHeight + 6;
               _vBox.addChild(_loc1_);
            }
            _loc2_++;
         }
      }
      
      private function __fallLinkHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("goldendionysia",2);
      }
      
      override public function dispose() : void
      {
         _fallLinkTxt.removeEventListener("click",__fallLinkHandler);
         ObjectUtils.disposeObject(_luckyListBg);
         _luckyListBg = null;
         ObjectUtils.disposeObject(_luckyListNote);
         _luckyListNote = null;
         ObjectUtils.disposeObject(_frame1);
         _frame1 = null;
         ObjectUtils.disposeObject(_frame2);
         _frame2 = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_fallLinkTxt);
         _fallLinkTxt = null;
         super.dispose();
      }
   }
}

