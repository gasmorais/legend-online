package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.TheseusTreasureGrowupInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.goods.TreasureTip;
   
   public class TreasureIntensifyTip extends BaseTip
   {
      
      private var _intensifyIcon:Bitmap;
      
      private var _goodstip1:TreasureTip;
      
      private var _goodstip2:TreasureTip;
      
      public function TreasureIntensifyTip()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg.parent && _bg.parent.removeChild(_bg);
         _goodstip1 = new TreasureTip();
         _goodstip2 = new TreasureTip();
         _goodstip2.x = _goodstip1.width + 80;
         _intensifyIcon = ComponentFactory.Instance.creatBitmap("asset.mainToolBar.IntensifyIcon");
         addChild(_goodstip1);
         addChild(_goodstip2);
         addChild(_intensifyIcon);
      }
      
      override public function set tipData(param1:Object) : void
      {
         _data = param1;
         _goodstip1.tipData = _data;
         var _loc2_:GoodsInfo = _data as GoodsInfo;
         if(_loc2_)
         {
            if(_loc2_.strengthenGrade >= _loc2_.templateInfo.StrengthenMax)
            {
               _intensifyIcon.parent && _intensifyIcon.parent.removeChild(_intensifyIcon);
               _goodstip2.parent && _goodstip2.parent.removeChild(_goodstip2);
               return;
            }
            _goodstip2.parent || addChild(_goodstip2);
            _intensifyIcon.parent || addChild(_intensifyIcon);
            _intensifyIcon.x = _goodstip1.x + _goodstip1.width - 16;
            _intensifyIcon.y = _goodstip1.y + (_goodstip1.height - _intensifyIcon.height) / 2;
            _loc2_ = getNextGrade(_loc2_);
            _goodstip2.tipData = _loc2_;
            _goodstip2.x = _goodstip1.x + _goodstip1.width + 29;
         }
      }
      
      private function getNextGrade(param1:GoodsInfo) : GoodsInfo
      {
         var _loc3_:TheseusTreasureGrowupInfo = getGrowupInfo(param1.templateId,param1.strengthenGrade + 1);
         return copyGoods(param1,_loc3_);
      }
      
      private function getGrowupInfo(param1:int, param2:int) : TheseusTreasureGrowupInfo
      {
         return TempleteManager.instance.theseusTreasureGrowupCate.getTempInfoByIdLevel(param1,param2);
      }
      
      private function copyGoods(param1:GoodsInfo, param2:TheseusTreasureGrowupInfo) : GoodsInfo
      {
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.id = param1.id;
         _loc3_.templateId = param2.TreasureId;
         _loc3_.strengthenGrade = param2.TreasureLevel;
         _loc3_.templateInfo.Attack = param2.PhyAttack;
         _loc3_.templateInfo.Defence = param2.PhyDefence;
         _loc3_.templateInfo.MagicAttack = param2.MagicAttack;
         _loc3_.templateInfo.MagicDefence = param2.MagicDefence;
         _loc3_.templateInfo.ForceHit = param2.ForceHit;
         _loc3_.templateInfo.Live = param2.Live;
         _loc3_.templateInfo.Parry = param2.Parry;
         _loc3_.templateInfo.Penetrate = param2.Penetrate;
         _loc3_.templateInfo.ReduceResi = param2.ReduceResi;
         _loc3_.templateInfo.FireResi = param2.FireResi;
         _loc3_.templateInfo.WaterResi = param2.WaterResi;
         _loc3_.templateInfo.ElectResi = param2.ElectResi;
         _loc3_.templateInfo.WindResi = param2.WindResi;
         _loc3_.templateInfo.DarkResi = param2.DarkResi;
         _loc3_.templateInfo.LightResi = param2.LightResi;
         _loc3_.templateInfo.ReduceResiAgainst = param2.ReduceResiAgainst;
         _loc3_.templateInfo.ResiPenetrate = param2.ResiPenetrate;
         _loc3_.randomSkill1 = param1.randomSkill1;
         _loc3_.randomSkill2 = param1.randomSkill2;
         _loc3_.randomSkill3 = param1.randomSkill3;
         _loc3_.randomSkill4 = param1.randomSkill4;
         _loc3_.randomSkill5 = param1.randomSkill5;
         return _loc3_;
      }
      
      override public function dispose() : void
      {
         if(_intensifyIcon)
         {
            ObjectUtils.disposeObject(_intensifyIcon);
         }
         _intensifyIcon = null;
         if(_goodstip1)
         {
            ObjectUtils.disposeObject(_goodstip1);
         }
         _goodstip1 = null;
         if(_goodstip2)
         {
            ObjectUtils.disposeObject(_goodstip2);
         }
         _goodstip2 = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

