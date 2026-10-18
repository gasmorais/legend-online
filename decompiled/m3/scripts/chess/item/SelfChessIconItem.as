package chess.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.datas.templates.SelfChessTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class SelfChessIconItem extends Sprite
   {
      
      private var _bg:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _heroId:int;
      
      public function SelfChessIconItem()
      {
         super();
         initView();
      }
      
      public function set heroId(param1:int) : void
      {
         var _loc2_:SelfChessTempInfo = null;
         _heroId = param1;
         if(_heroId == 0)
         {
            _icon.visible = false;
         }
         else
         {
            _icon.visible = true;
            _loc2_ = TempleteManager.instance.selfChessTempCate.getTempById(_heroId);
            _icon.icon = PathManager.solveCampaignMovieByUrl(_loc2_.Icon);
         }
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.selfchess.box40");
         _icon = ComponentFactory.Instance.creatCustomObject("ui.selfchess.tipPlayHeroIcon");
         addChild(_bg);
         addChild(_icon);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

