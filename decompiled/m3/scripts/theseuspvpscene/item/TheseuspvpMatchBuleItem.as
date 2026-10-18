package theseuspvpscene.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.theseuspvp.TheseusPvpMatchPlayerInfo;
   import yishi.datas.templates.TheseusPvpTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.base.NumberBitmap;
   
   public class TheseuspvpMatchBuleItem extends Sprite
   {
      
      public var _matchBlueBg:Bitmap;
      
      public var _buleMatchIcon:ScaleFrameImage;
      
      public var _blueMatchTxt:FilterFrameText;
      
      private var _data:TheseusPvpMatchPlayerInfo;
      
      private var _bitnum:NumberBitmap;
      
      private var _half:TheseuspvpHalfSwfIcon;
      
      private var _vBg:Image;
      
      private var _scoreTxt:FilterFrameText;
      
      public function TheseuspvpMatchBuleItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _matchBlueBg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.matchBlueBg");
         _half = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.HalfBuleIcon");
         _buleMatchIcon = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.MidStepIcon");
         _blueMatchTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.blueMatchTxt");
         _bitnum = new NumberBitmap();
         _bitnum = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.blueMatchNum");
         _bitnum.initParams("asset.theseuspvp.matchBlueT","asset.theseuspvp.matchBlueD",26,33,22,26,"0123456789",106,-4);
         _vBg = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.blueMatchVbg");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.blueMatchSTxt");
         addChild(_matchBlueBg);
         addChild(_half);
         addChild(_buleMatchIcon);
         addChild(_blueMatchTxt);
         addChild(_bitnum);
         addChild(_vBg);
         addChild(_scoreTxt);
         _buleMatchIcon.x = 129;
         _buleMatchIcon.y = 85;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_matchBlueBg);
         _matchBlueBg = null;
         ObjectUtils.disposeObject(_half);
         _half = null;
         ObjectUtils.disposeObject(_buleMatchIcon);
         _buleMatchIcon = null;
         ObjectUtils.disposeObject(_blueMatchTxt);
         _blueMatchTxt = null;
         ObjectUtils.disposeObject(_bitnum);
         _bitnum = null;
         ObjectUtils.disposeObject(_vBg);
         _vBg = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
      
      public function get data() : TheseusPvpMatchPlayerInfo
      {
         return _data;
      }
      
      public function set data(param1:TheseusPvpMatchPlayerInfo) : void
      {
         var _loc2_:TheseusPvpTempInfo = null;
         _data = param1;
         if(_data)
         {
            _loc2_ = TempleteManager.instance.theseusPvpTempCate.getTempById(_data.pvpId);
            if(_loc2_)
            {
               _buleMatchIcon.setFrame(_loc2_.MainType);
            }
            _blueMatchTxt.text = _data.nickName + "[" + _data.serverName + "]";
            _bitnum.num = _data.fightCapacity;
            _half.job = _data.job;
            _scoreTxt.text = "" + _data.integral;
         }
      }
   }
}

