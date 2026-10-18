package apex.report
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import mvc.module.apex.ApexResultData;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.ApexManager;
   
   public class ApexReportView extends Frame
   {
      
      private var _bit0:Bitmap;
      
      private var _bit1:Bitmap;
      
      private var _bit2:Bitmap;
      
      private var _bit3:Bitmap;
      
      private var _bit5:Bitmap;
      
      private var _bit7:Bitmap;
      
      private var _apexRankBtnOK:IconButton;
      
      private var _bit8:Bitmap;
      
      private var _imgReportGroup:ScaleFrameImage;
      
      private var _txtReportRank:FilterFrameText;
      
      private var _txtReportAward:FilterFrameText;
      
      private var _imgReportTurn:ScaleFrameImage;
      
      private var _bit9:Bitmap;
      
      public function ApexReportView()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _bit0 = ComponentFactory.Instance.creatBitmap("asset.apex.report.img1");
         _bit1 = ComponentFactory.Instance.creatBitmap("asset.apex.report.img2");
         _bit2 = ComponentFactory.Instance.creatBitmap("asset.apex.report.str1");
         _bit3 = ComponentFactory.Instance.creatBitmap("asset.apex.report.str2");
         _bit5 = ComponentFactory.Instance.creatBitmap("asset.apex.report.str4");
         _bit7 = ComponentFactory.Instance.creatBitmap("asset.apex.report.str6");
         _apexRankBtnOK = ComponentFactory.Instance.creatComponentByStylename("ui.apex.apexRankBtnOK");
         _bit8 = ComponentFactory.Instance.creatBitmap("asset.apex.report.title");
         _imgReportGroup = ComponentFactory.Instance.creatComponentByStylename("ui.apex.imgReportGroup");
         _txtReportRank = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtReportRank");
         _txtReportAward = ComponentFactory.Instance.creatComponentByStylename("ui.apex.txtReportAward");
         _imgReportTurn = ComponentFactory.Instance.creatComponentByStylename("ui.apex.imgReportTurn");
         _bit9 = ComponentFactory.Instance.creatBitmap("asset.apex.report.bg");
         addChild(_bit9);
         addChild(_bit0);
         addChild(_bit1);
         addChild(_bit2);
         addChild(_bit3);
         addChild(_bit5);
         addChild(_bit7);
         addChild(_apexRankBtnOK);
         addChild(_bit8);
         addChild(_imgReportGroup);
         addChild(_txtReportRank);
         addChild(_txtReportAward);
         addChild(_imgReportTurn);
         if(data)
         {
            _imgReportGroup.setFrame(data.currentGroup);
            _txtReportRank.text = data.selfRank + "";
            _txtReportAward.text = data.awardStr;
         }
         _imgReportTurn.setFrame(ApexManager.instance.model.apexState.stage);
      }
      
      private function addEvent() : void
      {
         _apexRankBtnOK.addEventListener("click",clickOK);
      }
      
      private function removeEvent() : void
      {
         if(_apexRankBtnOK)
         {
            _apexRankBtnOK.removeEventListener("click",clickOK);
         }
      }
      
      protected function clickOK(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      private function get data() : ApexResultData
      {
         return ApexManager.instance.model.apexResultData;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bit0);
         _bit0 = null;
         ObjectUtils.disposeObject(_bit1);
         _bit1 = null;
         ObjectUtils.disposeObject(_bit2);
         _bit2 = null;
         ObjectUtils.disposeObject(_bit3);
         _bit3 = null;
         ObjectUtils.disposeObject(_bit5);
         _bit5 = null;
         ObjectUtils.disposeObject(_bit7);
         _bit7 = null;
         ObjectUtils.disposeObject(_apexRankBtnOK);
         _apexRankBtnOK = null;
         ObjectUtils.disposeObject(_bit8);
         _bit8 = null;
         ObjectUtils.disposeObject(_imgReportGroup);
         _imgReportGroup = null;
         ObjectUtils.disposeObject(_txtReportRank);
         _txtReportRank = null;
         ObjectUtils.disposeObject(_txtReportAward);
         _txtReportAward = null;
         ObjectUtils.disposeObject(_bit9);
         _bit9 = null;
         ObjectUtils.disposeObject(_imgReportTurn);
         _imgReportTurn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

