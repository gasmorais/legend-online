package map.internals.view.treasuremap.getframe
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.TempleteManager;
   
   public class TreasureMapGetItemView extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private var _treasureMap:Bitmap;
      
      private var _selected:Bitmap;
      
      private var _rewardTxt:FilterFrameText;
      
      private var _index:int;
      
      private var _filter:IFilterFormat;
      
      private var _data:GoodsTemplateInfo;
      
      private var _reward:GoodsTemplateInfo;
      
      public function TreasureMapGetItemView(param1:int)
      {
         super();
         _index = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.treasuremap.MapBgAsset" + _index);
         _treasureMap = ComponentFactory.Instance.creatBitmap("asset.treasuremap.MapAsset" + _index);
         _selected = ComponentFactory.Instance.creatBitmap("asset.treasuremap.MapSelected" + _index);
         _rewardTxt = ComponentFactory.Instance.creatComponentByStylename("treasuremap.TreasureMapGetItemView.MapRewardTxt");
         addChild(_bg);
         addChild(_selected);
         addChild(_treasureMap);
         addChild(_rewardTxt);
         _filter = new UIFilter();
         _reward = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208028);
         selected = false;
         discard = false;
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_selected);
         _selected = null;
         ObjectUtils.disposeObject(_treasureMap);
         _treasureMap = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected.visible = param1;
      }
      
      public function set discard(param1:Boolean) : void
      {
         if(param1)
         {
            _filter.setGrayFilter(this);
         }
         else
         {
            _filter.setNormalFilter(this);
         }
      }
      
      public function get data() : GoodsTemplateInfo
      {
         return _data;
      }
      
      public function set data(param1:GoodsTemplateInfo) : void
      {
         _data = param1;
         if(_data)
         {
            _rewardTxt.text = LanguageMgr.GetTranslation("map.internals.view.treasuremap.TreasureMapGetFrame.RewardTipsTxt",_reward.TemplateName,_data.Property6 * 4);
         }
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

