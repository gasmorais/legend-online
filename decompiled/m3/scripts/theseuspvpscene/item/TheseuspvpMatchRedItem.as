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
   
   public class TheseuspvpMatchRedItem extends Sprite
   {
      
      public var _matchRedBg:Bitmap;
      
      public var _redMatchIcon:ScaleFrameImage;
      
      public var _redMatchTxt:FilterFrameText;
      
      private var _data:TheseusPvpMatchPlayerInfo;
      
      private var _bitnum:NumberBitmap;
      
      private var _half:TheseuspvpHalfSwfIcon;
      
      private var _vBg:Image;
      
      private var _scoreTxt:FilterFrameText;
      
      public function TheseuspvpMatchRedItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _matchRedBg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.matchRedBg");
         _half = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.HalfRedIcon");
         _redMatchIcon = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.MidStepIcon");
         _redMatchTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.redMatchTxt");
         _bitnum = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.redMatchNum");
         _bitnum.initParams("asset.theseuspvp.matchRedT","asset.theseuspvp.matchRedD",26,33,22,26,"0123456789",106,-4);
         _vBg = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.redMatchVbg");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.redMatchSTxt");
         addChild(_matchRedBg);
         addChild(_half);
         addChild(_redMatchIcon);
         addChild(_redMatchTxt);
         addChild(_bitnum);
         addChild(_vBg);
         addChild(_scoreTxt);
         _redMatchIcon.x = 332;
         _redMatchIcon.y = 38;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_matchRedBg);
         _matchRedBg = null;
         ObjectUtils.disposeObject(_half);
         _half = null;
         ObjectUtils.disposeObject(_redMatchIcon);
         _redMatchIcon = null;
         ObjectUtils.disposeObject(_redMatchTxt);
         _redMatchTxt = null;
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
               _redMatchIcon.setFrame(_loc2_.MainType);
            }
            _redMatchTxt.text = _data.nickName + "[" + _data.serverName + "]";
            _bitnum.num = _data.fightCapacity;
            _half.job = _data.job;
            _scoreTxt.text = "" + _data.integral;
         }
      }
   }
}

