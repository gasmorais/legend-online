package childnswar.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.childnswar.ChildNswarRankInfo;
   import theseuspvp.item.TheseusPvpHeadIcon;
   import yishi.datas.templates.ChildNswarTempInfo;
   import yishi.manager.TempleteManager;
   
   public class ChildNswarRankItem extends Sprite
   {
      
      private var _coreBg:ScaleBitmapImage;
      
      private var _allsItemHead:Image;
      
      private var _sortTagbg:Bitmap;
      
      private var _allsVbg:Image;
      
      private var _allsGolryTxt:FilterFrameText;
      
      private var _allsIcon:ScaleFrameImage;
      
      private var _allsSIdx:FilterFrameText;
      
      private var _allsNickNameTxt:FilterFrameText;
      
      private var _allsServerNameTxt:FilterFrameText;
      
      private var _icon:TheseusPvpHeadIcon;
      
      private var _isSelf:Boolean;
      
      private var _data:ChildNswarRankInfo;
      
      public function ChildNswarRankItem(param1:Boolean = false)
      {
         super();
         this._isSelf = param1;
         initView();
      }
      
      private function initView() : void
      {
         if(!_isSelf)
         {
            _coreBg = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.coreBg");
         }
         _allsItemHead = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.allsItemHead");
         _sortTagbg = ComponentFactory.Instance.creatBitmap("asset.theseuspvp.sortTagbg");
         _allsVbg = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.allsVbg");
         _allsGolryTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.allsGolryTxt");
         _allsIcon = ComponentFactory.Instance.creatComponentByStylename("ui.childnswar.allsIcon");
         _allsSIdx = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.allsSIdx");
         _allsNickNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.allsNickNameTxt");
         _allsServerNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.theseuspvp.allsServerNameTxt");
         _icon = ComponentFactory.Instance.creatCustomObject("ui.theseuspvp.sortItemHeadIcon");
         if(_coreBg)
         {
            addChild(_coreBg);
         }
         addChild(_allsItemHead);
         addChild(_icon);
         addChild(_sortTagbg);
         addChild(_allsVbg);
         addChild(_allsGolryTxt);
         addChild(_allsIcon);
         addChild(_allsSIdx);
         addChild(_allsNickNameTxt);
         addChild(_allsServerNameTxt);
         if(_coreBg)
         {
            _coreBg.width = 528;
            _coreBg.height = 73;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_coreBg);
         _coreBg = null;
         ObjectUtils.disposeObject(_allsItemHead);
         _allsItemHead = null;
         ObjectUtils.disposeObject(_sortTagbg);
         _sortTagbg = null;
         ObjectUtils.disposeObject(_allsVbg);
         _allsVbg = null;
         ObjectUtils.disposeObject(_allsGolryTxt);
         _allsGolryTxt = null;
         ObjectUtils.disposeObject(_allsIcon);
         _allsIcon = null;
         ObjectUtils.disposeObject(_allsSIdx);
         _allsSIdx = null;
         ObjectUtils.disposeObject(_allsNickNameTxt);
         _allsNickNameTxt = null;
         ObjectUtils.disposeObject(_allsServerNameTxt);
         _allsServerNameTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      public function get data() : ChildNswarRankInfo
      {
         return _data;
      }
      
      public function set data(param1:ChildNswarRankInfo) : void
      {
         var _loc2_:ChildNswarTempInfo = null;
         _data = param1;
         if(_data)
         {
            _allsNickNameTxt.text = _data.nickName;
            _allsServerNameTxt.text = _data.serverName;
            _allsSIdx.text = _data.rank == 0 ? "100+" : "" + _data.rank;
            _allsGolryTxt.text = "" + _data.integral;
            _icon.headIcon = _data.job;
            _loc2_ = TempleteManager.instance.childNswarCate.getTempById(_data.pvpId);
            if(_loc2_)
            {
               _allsIcon.setFrame(_loc2_.MainType);
            }
         }
      }
   }
}

