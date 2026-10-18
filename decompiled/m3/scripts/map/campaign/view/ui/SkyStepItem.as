package map.campaign.view.ui
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import map.internals.data.CampaignNode;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseIconView;
   
   public class SkyStepItem extends Component implements IManualSize
   {
      
      private static const BOSS:int = 6;
      
      private var _icon:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _chest:ScaleFrameImage;
      
      private var _line:Bitmap;
      
      private var _iconView:BaseIconView;
      
      private var _die:Bitmap;
      
      private var _light:Bitmap;
      
      private var _mc:MovieClip;
      
      private var _index:int;
      
      private const COUNT:int = 3;
      
      public function SkyStepItem(param1:int)
      {
         super();
         _index = param1;
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,207,52);
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatBitmap("asset.skyStepItem.icon");
         _txt = ComponentFactory.Instance.creatComponentByStylename("skyStepItem.txt");
         _chest = ComponentFactory.Instance.creatComponentByStylename("skyStepItem.chest");
         _line = ComponentFactory.Instance.creatBitmap("asset.skyStepItem.line");
         _iconView = ComponentFactory.Instance.creatCustomObject("skyStepItem.view");
         _die = ComponentFactory.Instance.creatBitmap("asset.skyStepItem.die");
         _light = ComponentFactory.Instance.creatBitmap("asset.skyStepItem.light");
         _mc = ComponentFactory.Instance.creatCustomObject("skyStepItem.fightMc");
         addChild(_icon);
         addChild(_txt);
         addChild(_light);
         addChild(_chest);
         addChild(_line);
         addChild(_iconView);
         addChild(_die);
         addChild(_mc);
         _iconView.mask = createSprite();
         _mc.gotoAndStop(1);
      }
      
      private function createSprite() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawCircle(32,25,18);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         return _loc1_;
      }
      
      public function refreshView(param1:CampaignNode) : void
      {
         var _loc7_:GoodsInfo = null;
         var _loc8_:CommonDropTempInfo = null;
         var _loc4_:int = 0;
         if(!param1)
         {
            return;
         }
         _chest.setFrame(_index + 1);
         _txt.text = param1.info.names;
         var _loc6_:GameHeroTempInfo = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(param1.heroTemplateId);
         if(_index == 6 && param1.info.state == 0)
         {
            _iconView.icon = PathManager.info.ResourcePath + "icon/head_unknown.jpg";
         }
         else
         {
            _iconView.icon = PathManager.info.ResourcePath + "icon" + _loc6_.Icon;
         }
         _die.visible = false;
         _light.visible = false;
         _mc.visible = false;
         _mc.gotoAndStop(1);
         switch(int(param1.info.state) - 4)
         {
            case 0:
               _mc.gotoAndPlay(1);
               _mc.visible = true;
               break;
            case 4:
               _die.visible = true;
               _light.visible = true;
         }
         var _loc3_:int = 0;
         var _loc2_:Array = [];
         var _loc5_:Array = TempleteManager.instance.skyStepDropTempCate.getInfoByDropId(param1.nodeId);
         if(_loc5_.length > 0)
         {
            _loc5_.sortOn("id",16);
            _loc3_ = Math.min(3,_loc5_.length);
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc8_ = _loc5_[_loc4_];
               _loc7_ = new GoodsInfo();
               _loc7_.templateId = _loc8_.itemId;
               _loc7_.count = _loc8_.count;
               _loc2_.push(_loc7_);
               _loc4_++;
            }
            _chest.tipData = _loc2_;
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_chest);
         _chest = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_iconView);
         _iconView = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

