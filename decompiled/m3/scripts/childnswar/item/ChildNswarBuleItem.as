package childnswar.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.childnswar.ChildNswarMatchPlayInfo;
   import theseuspvpscene.item.TheseuspvpHalfSwfIcon;
   import yishi.datas.templates.ChildNswarTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.base.NumberBitmap;
   
   public class ChildNswarBuleItem extends Sprite
   {
      
      public var _matchBlueBg:Bitmap;
      
      public var _buleMatchIcon:ScaleFrameImage;
      
      public var _blueMatchTxt:FilterFrameText;
      
      private var _data:ChildNswarMatchPlayInfo;
      
      private var _bitnum:NumberBitmap;
      
      private var _half:TheseuspvpHalfSwfIcon;
      
      private var _vBg:Image;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _nsAvatar:ChildNswarAvatarLoader;
      
      public function ChildNswarBuleItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _matchBlueBg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.matchBlueBg");
         _half = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.HalfBuleIcon");
         _buleMatchIcon = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.MidStepIcon");
         _blueMatchTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.blueMatchTxt");
         _bitnum = new NumberBitmap();
         _bitnum = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.blueMatchNum");
         _bitnum.initParams("asset.childnswar.fightBlueFt","asset.theseuspvp.matchBlueD",26,33,22,26,"0123456789",76,-4);
         _vBg = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.blueMatchVbg");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.blueMatchSTxt");
         _nsAvatar = new ChildNswarAvatarLoader();
         addChild(_matchBlueBg);
         addChild(_half);
         addChild(_nsAvatar);
         addChild(_buleMatchIcon);
         addChild(_blueMatchTxt);
         addChild(_bitnum);
         addChild(_vBg);
         addChild(_scoreTxt);
         _buleMatchIcon.x = 129;
         _buleMatchIcon.y = 85;
         _nsAvatar.x = 612;
         _nsAvatar.y = 180;
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
         ObjectUtils.disposeObject(_nsAvatar);
         _nsAvatar = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
      
      public function get data() : ChildNswarMatchPlayInfo
      {
         return _data;
      }
      
      public function set data(param1:ChildNswarMatchPlayInfo) : void
      {
         var _loc2_:ChildNswarTempInfo = null;
         _data = param1;
         if(_data)
         {
            _loc2_ = TempleteManager.instance.childNswarCate.getTempById(_data.pvpId);
            if(_loc2_)
            {
               _buleMatchIcon.setFrame(_loc2_.MainType);
            }
            _blueMatchTxt.text = _data.nickName + "[" + _data.serverName + "]";
            _bitnum.num = _data.fightCapacity;
            _scoreTxt.text = "" + _data.integral;
            if(_data.grade > 0)
            {
               _nsAvatar.refresh(_data.job,_data.grade);
            }
            else
            {
               _half.job = _data.job;
            }
         }
      }
   }
}

