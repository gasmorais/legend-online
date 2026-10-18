package theseusdoublepvp.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.pvp.TheseusMultiPvpMatchPlayerMsg;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import theseuspvp.item.TheseusPvpHeadIcon;
   import yishi.datas.templates.TheseusMultiPvpTempInfo;
   import yishi.manager.TempleteManager;
   
   public class TheseusVsRed extends Sprite
   {
      
      protected var _redBg:Bitmap;
      
      protected var _matchNameredTxt:FilterFrameText;
      
      protected var _matchrankredTxt:FilterFrameText;
      
      private var _headIcon1:TheseusPvpHeadIcon;
      
      public var _redMatchIcon:ScaleFrameImage;
      
      private var _data:TheseusMultiPvpMatchPlayerMsg;
      
      public function TheseusVsRed()
      {
         super();
         initView();
      }
      
      protected function initView() : void
      {
         _redBg = ComponentFactory.Instance.creatBitmap("asset.theseuspve.double.redBg");
         _matchNameredTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuepvp.matchNameredTxt");
         _matchrankredTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuepvp.matchrankredTxt");
         _headIcon1 = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.topHeadIcon1");
         _redMatchIcon = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.MidStepIcon");
         _headIcon1.scaleX = _headIcon1.scaleY = 1.2;
         _headIcon1.x = 18;
         _headIcon1.y = 20;
         _redMatchIcon.x = 130;
         _redMatchIcon.y = 20;
         addChild(_redBg);
         addChild(_matchNameredTxt);
         addChild(_matchrankredTxt);
         addChild(_headIcon1);
         addChild(_redMatchIcon);
      }
      
      public function get data() : TheseusMultiPvpMatchPlayerMsg
      {
         return _data;
      }
      
      public function set data(param1:TheseusMultiPvpMatchPlayerMsg) : void
      {
         var _loc2_:TheseusMultiPvpTempInfo = null;
         _data = param1;
         if(_data)
         {
            _loc2_ = TempleteManager.instance.theseusMultiPvpTempCate.getTempById(_data.pvpId);
            if(_loc2_)
            {
               _redMatchIcon.setFrame(_loc2_.MainType);
            }
            _matchNameredTxt.text = _data.nickName + "[" + _data.serverName + "]";
            _headIcon1.headIcon = _data.job;
            _matchrankredTxt.text = _loc2_.Name + " " + _data.integral;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_redBg);
         _redBg = null;
         ObjectUtils.disposeObject(_matchNameredTxt);
         _matchNameredTxt = null;
         ObjectUtils.disposeObject(_matchrankredTxt);
         _matchrankredTxt = null;
         ObjectUtils.disposeObject(_headIcon1);
         _headIcon1 = null;
         ObjectUtils.disposeObject(_redMatchIcon);
         _redMatchIcon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

