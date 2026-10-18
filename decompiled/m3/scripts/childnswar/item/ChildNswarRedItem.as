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
   
   public class ChildNswarRedItem extends Sprite
   {
      
      public var _matchRedBg:Bitmap;
      
      public var _redMatchIcon:ScaleFrameImage;
      
      public var _redMatchTxt:FilterFrameText;
      
      private var _data:ChildNswarMatchPlayInfo;
      
      private var _bitnum:NumberBitmap;
      
      private var _half:TheseuspvpHalfSwfIcon;
      
      private var _vBg:Image;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _nsAvatar:ChildNswarAvatarLoader;
      
      public function ChildNswarRedItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _matchRedBg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.matchRedBg");
         _half = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.HalfRedIcon");
         _redMatchIcon = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.MidStepIcon");
         _redMatchTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.redMatchTxt");
         _bitnum = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.redMatchNum");
         _bitnum.initParams("asset.childnswar.fightRedFt","asset.theseuspvp.matchRedD",26,33,22,26,"0123456789",176,-4);
         _vBg = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.redMatchVbg");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.redMatchSTxt");
         _nsAvatar = new ChildNswarAvatarLoader();
         addChild(_matchRedBg);
         addChild(_half);
         addChild(_nsAvatar);
         addChild(_redMatchIcon);
         addChild(_redMatchTxt);
         addChild(_bitnum);
         addChild(_vBg);
         addChild(_scoreTxt);
         _redMatchIcon.x = 332;
         _redMatchIcon.y = 38;
         _nsAvatar.x = 113;
         _nsAvatar.y = 236;
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
               _redMatchIcon.setFrame(_loc2_.MainType);
            }
            _redMatchTxt.text = _data.nickName + "[" + _data.serverName + "]";
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

